import argparse
import os
import re
import sys
from typing import Dict, List, Pattern

from antlr4 import *

from gen.CellsLexer import CellsLexer
from gen.CellsListener import CellsListener
from gen.CellsParser import CellsParser


class Pin:
    """
    Class to store data each IO line in the cell export
    """
    module: str
    pin_name: str
    net_name: str
    cell_name: str
    connected_pins: List[str]

    def __init__(self, cell_name, pin_name, net_name, connected_pins, module) -> None:
        """
        :param
            cell_name - name of the cell where the pin belongs to
            pin_name - name of the pin
            net_name - name of the net where the pin belongs to
            connected_pins - pins which are connected to the current pin
            module - module where the pin belongs to
        """
        super().__init__()
        self.module = module
        self.net_name = net_name
        self.pin_name = pin_name
        self.cell_name = cell_name
        self.connected_pins = connected_pins


class CellParser(CellsListener):
    """
    Parses te parse tree and writes found pins and the information about their the modules 
    they belong to into the output file.
    """

    def __init__(self, debug):
        """
        :param
            debug - dict containing the list of debugging actions to be taken
        """
        CellsListener.__init__(self)

        self.debug = debug

        self.num_cells = 0
        self.multi_module_counter = 0
        self.module_fallback_counter = 0

        self.detected_as_none = 0
        self.detection_by_cell_name = 0
        self.detection_by_pin_names = 0
        self.detection_by_map = 0

        self.module_guess_counter = 0

        self.outstream = None
        self.signal_module_map = None
        self.fault_locs_per_module: Dict[str, Pin] = {}

    def exitCell(self, ctx: CellsParser.CellContext):
        """
        Processes a cell in the cell export file. Called when the ANTLR parser exits 
        a Cell node. Will process the cell and output all its pins with the name of 
        the module they belong to into an output file.

        :param
            ctx - Pointer to the cell to be processed in the ANTLR parse tree
        """
        modules = []
        io_pins = []
        pins: List[Pin] = []

        self.num_cells += 1

        # Get the name of the current cell
        # r.cell.header.nameline.<name>
        cell_name = ctx.children[0].children[0].children[1].symbol.text

        # Extract all io_pins in the cell (outputs and inputs)
        # [r.cell.inputs.io_pin[0:n] + (r.cell.outputs.io_pin[0:n], if outputs exist)]
        io_pins = ctx.children[1].children[7:] + \
            (ctx.children[2].children[7:] if len(ctx.children) > 2 else [])

        # Create one Pin object for each io_pin which is connected to the cell and
        # try to guess to which module they belong to
        for io_pin in io_pins:
            pin_name, net_name, connected_pins = self.handleIOPin(io_pin)
            module = self.guessModule(ctx, cell_name, net_name,
                                      connected_pins, self.signal_module_map)

            if module != None:
                modules.append(module)

            pins.append(Pin(cell_name, pin_name,
                            net_name, connected_pins, module))

        if len(set(modules)) > 1:
            self.multi_module_counter += 1

       # If pin had no information module information attached to it, take a guess and
       # assign it to one of the modules other pins of the cell are connected to
        if modules:
            for io_pin in pins:
                if io_pin.module == None:
                    io_pin.module = modules[0]
                    self.module_guess_counter += 1

        else:  # If we had absolutely no information for to guess the pin name
            for io_pin in pins:
                io_pin.module = 'none'
                self.module_fallback_counter += 1

        # Counts the number of fault injection locations per module
        for io_pin in pins:
            if io_pin.module in self.fault_locs_per_module:
                self.fault_locs_per_module[io_pin.module] += 1

            else:
                self.fault_locs_per_module[io_pin.module] = 1

            # Finally save the fault injection location to the output file
            print(("" if io_pin.cell_name.startswith("U") else "\\") + io_pin.cell_name +
                  " :" + io_pin.pin_name + ' ' + '!' + io_pin.module, file=self.outstream)

    def handleIOPin(self, ctx):
        """
        Processes an IO pin and extract relevant information from it

        :param
            ctx ANTLR pointer to the IO pin which is currently processed

        :return
            List [pin_name, net_name, connected_pins], where
                pin_name - name of the current IO pin
                net_name - name of the net where the current IO pin belongs to
                connected_pins - list of pins which are connected to the current pin

        Example IO pin in the cell export:
            Connections for cell 'U670': [...]
            Input pins          Net            Net Driver pins   Driver Pin Type
            ----------------    ------------   ----------------  ----------------
            A                   FIFO_N/n411    FIFO_N/U337/Q     Output Pin (XNOR2X6)
        """

        def conv_pin_type(node):
            """
            Converts connected pin information into a string.

            :param 
                node - connected pin information
                        (r.cell.inputs.io_pin[n].connected_pins[0:n].pin_type.<type_name>.<pin_data>)
            :return
                Formated connected pin information as string
            """

            # Format of node.children is (example): ['Input Pin', '(', OAI32X3, ')']
            # if len(node.children) >= 3, then it means there is a name there for the pin also (OAI32X3)
            if(len(node.children) >= 3):
                # Ex: 'Input Pin(OAI32X3)'
                return str(node.children[0]) + '(' + str(node.children[2]) + ')'
            else:
                # Ex: 'Input Pin'
                return str(node.children[0])

        # A (r.cell.inputs.io_pin[n].pin_name.<name>)
        pin_name = str(ctx.children[0].children[0])

        # FIFO_N/n411 (r.cell.inputs.io_pin[n].net_name.<name>)
        net_name = str(ctx.children[1].children[0] if not isinstance(
            ctx.children[1], TerminalNode) else 'None')

        # [ ( FIFO_N/U337/Q , Output Pin (XNOR2X6) ) ]
        # dict(r.cell.inputs.io_pin[n].connected_pins[0:n].<name>, r.cell.inputs.io_pin[n].connected_pins[0:n].pin_type.<type_name>),
        # if there are connected pins
        connected_pins = [(str(pin.children[1]), conv_pin_type(pin.children[3].children[0]))
                          for pin in ctx.children[2].children] if net_name is not 'None' else 'None'

        return pin_name, net_name, connected_pins

    def guessModule(self, ctx, cell_name, net_name, connected_pins, signal_module_map):
        """
        Guesses to which module the io_pin belongs to.
        :param
            ctx - pointer to the current cell in ANTLR's parse tree
            cell_name - name of the cell the current pin belongs to
            net_name - name of the net where the current pin belongs to
            connected_pins - list of the pins connected to the current pin
            signal_module_map - a map which which is used to make decisions on the the belonging of the io_pin

        :return - module name - Name of the module (according to signal_module_map), where the pin belongs to.
                                        None if the module cannot be determined
        """

        def guessComponent():
            """
            Tries to guess the components the pin belongs to.
            Guessing is done in the following order:
                1. Cell name - passes if cell name can be matched against signal_module_map (trustworthy)
                2. Signal name - passes if signal names matches with some if the conditions in signal_module_map (not trustworthy)
                3. Connected pin name - passes if a valid pin name is detected. The first connected pin is used (not trustworthy)
                4. None - No Module name can be guessed for the pin

                List module name - String which contains the name of the module where the pin belongs to (hopefully).
                                        None if the module cannot be determined
            """

            connected_pin_names = []
            try:

                # Try to guess the module based on the nameline in the cell header
                # Skip cells with names like U23... nothing good comes from them...
                if not re.match('^U[0-9]+$', cell_name):
                    for signal in signal_module_map.keys():

                        if re.match(signal, cell_name):
                            self.detection_by_cell_name += 1
                            return cell_name

                # Try to guess the component based on the rules specified in signal_module_map.
                for signal_name in signal_module_map.keys():

                    if re.match(signal_name, net_name):
                        self.detection_by_map += 1
                        if self.debug['named_after_map']:
                            print('Cell:', cell_name, 'Net:', net_name,
                                  'Connected Pins', connected_pins, '->', net_name)
                        return net_name

                # List all pins connected to the current pin
                for pin in connected_pins:

                    # pin[0] = r.cell.inputs.io_pin[n].connected_pins[0:n].<name>
                    # Ex: CONTROL_PART/allocator_unit/arb_X_L/U28/B

                    # Skip pins with names like U23, nets with names like n32 and reset....
                    # nothing good comes from them also...
                    if not re.match('^U[0-9]+$', pin[0]) and \
                       not re.match('^n[0-9]+$', net_name) and \
                       not net_name == "reset":
                        connected_pin_names.append(pin[0])

                # Choose the first pin for component detection.
                if connected_pin_names:
                    self.detection_by_pin_names += 1
                    if self.debug['named_after_conn']:
                        print('Cell:', cell_name, 'Net:', net_name, 'Connected Pins',
                              connected_pins, '->', connected_pin_names[0])
                    # NOTE: By default the first pin is used for detection.
                    return connected_pin_names[0]

                # No module name found (probably had a cell with name like U23 or something...
                # I told you nothing good comes from them...)
                self.detected_as_none += 1
                if self.debug['no_module_name']:
                    print('Cell:', cell_name, 'Net:', net_name,
                          'Connected Pins', connected_pins, '->', 'None')
                return None

            except ValueError:
                print("Failed to guess component! %s" %
                      cell_name, file=sys.stderr)

                print(ctx, file=sys.stderr)

        # ---------------------
        # End of guessComponent

        comp = guessComponent()
        if not comp:
            return None

        if comp == 'nofault':  # Can guessComponent even return this value????
            return None

        # Check if component fits any of the conditions for signals set in the signal condition map
        for signal, module in signal_module_map.items():
            if re.match(signal, comp):
                return module

        return None


def main(cell_export_file, signal_module_map: Dict[Pattern[str], str], outfile, debug):
    """
    Parses the cell export file and prints results

    :param
        cell_export_file - path to the cell export file
        signal_module_map - map which maps different name patters to module names
        outfile - file where to write the output
        debug - Debug instructions
    """
    # Setting up ANTLR environment for parsing the cell export
    print('Creating parse tree...', file=sys.stderr)
    input_stream = FileStream(cell_export_file)
    lexer = CellsLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = CellsParser(stream)
    tree = parser.r()

    # Actually parse the cell export
    print('Parsing the cell export...', file=sys.stderr)
    printer = CellParser(debug)
    printer.signal_module_map = signal_module_map
    printer.outstream = outfile
    walker = ParseTreeWalker()
    walker.walk(printer, tree)

    # Print statistics
    total_fault_injection_locs = sum(printer.fault_locs_per_module.values())

    print()
    print(11 * '-')
    print('STATISTICS:')
    print(11 * '-')
    print()

    print('Total number of fault injection locations:',
          total_fault_injection_locs)

    print()
    print('Detected modules:', str(
        list(set(printer.fault_locs_per_module.keys()))))

    print()
    print('Fault injection locations per module:')
# sorted(dict1, key=dict1.get)
    longest_module_name_length = 0
    for module in printer.fault_locs_per_module.keys():
        if len(module) > longest_module_name_length:
            longest_module_name_length = len(module) + 1

    for module_name, fault_locs in sorted(printer.fault_locs_per_module.items(), key=lambda x: x[1]):
        length_difference = longest_module_name_length - len(module_name)
        print('\t' + module_name + ':' +
              length_difference * ' ' + str(fault_locs))

    print()
    print('Pins were assigned to modules according the following data:')

    print('\tCell name:         %d    \t(%f%%)' % (printer.detection_by_cell_name,
                                                   printer.detection_by_cell_name * 100 / total_fault_injection_locs))

    print('\tSignal-module map: %d    \t(%f%%)' % (printer.detection_by_map,
                                                   printer.detection_by_map * 100 / total_fault_injection_locs))

    print('\tConnected pins:    %d    \t(%f%%)' % (printer.detection_by_pin_names,
                                                   printer.detection_by_pin_names * 100 / total_fault_injection_locs))

    print('\tNo name found:     %d    \t(%f%%)' % (printer.detected_as_none,
                                                   printer.detected_as_none * 100 / total_fault_injection_locs))

    print('Had to semi-randomly guess the module for %d pins (%f%%).' % (printer.module_guess_counter,
                                                                         printer.module_guess_counter * 100 / total_fault_injection_locs))

    print()
    print('Pins were assigned to multiple different modules for %d cells. (%d total = %f%%)' % (
        printer.multi_module_counter, printer.num_cells, printer.multi_module_counter/printer.num_cells))

    if (printer.detection_by_cell_name + printer.detection_by_map) < total_fault_injection_locs:
        print()
        print('W A R N I N G ! - Not all modules for pins were detected from the cell name or signal-module map!\n'
              'This means you might want to make sure all logic in your design is located under respective submodules.\n'
              'Alternatively you might want to update the signal-module map. Proceed at your own risk')

    print()
    if printer.module_fallback_counter > 0:
        print('E R R O R ! - Had to choose \'none\' as fallback module on %d pins, '
              'because I could not guess to which module the io_pin belongs' %
              printer.module_fallback_counter)
        sys.exit(1)

    else:
        print('All pins were assigned into modules')

    print(11 * '-')


if __name__ == '__main__':

    if (sys.version_info < (3, 6)):
        print("This script is designed to run on Python 3.6 or newer!")
        exit(1)

    print()
    print('==================', file=sys.stderr)
    print('CELL EXPORT PARSER', file=sys.stderr)
    print('==================', file=sys.stderr)

    args = argparse.ArgumentParser(
        description='Creates a list of Fault injection locations for a router.')

    args.add_argument('routerdir', type=str,
                      help='The directory where the the router is located.')

    args.add_argument('--cellexport', nargs='?', type=str, default="Cells_Report_Verbose.txt",
                      help='Filename of the cellexport file in the router folder (defaults to \'Cells_Report_Verbose.txt\')')

    args.add_argument('--moduledict', nargs='?', type=str, default="pattern_to_modules.py",
                      help='Name of the file, which contains the dictionary for mapping the patterns in the cell export to  module names'
                      '(defaults to \'pattern_to_modules.py\').')

    debug_args = args.add_mutually_exclusive_group()
    debug_args.add_argument('--debug-named-after-map', action='store_true',
                            help='Prints all io_pins which get assigned to modules based on the rules in signal-module map')
    debug_args.add_argument('--debug-named-after-connection', action='store_true',
                            help='Prints all io_pins which get assigned to modules based on pins they are connected to')
    debug_args.add_argument('--debug-no-module', action='store_true',
                            help='Prints all io_pins where module guessing failed and were named after other pins in the same cell')

    args = args.parse_args()

    debug = dict(
        named_after_map=args.debug_named_after_map,
        named_after_conn=args.debug_named_after_connection,
        no_module_name=args.debug_no_module
    )

    with open(os.path.join(args.routerdir, args.cellexport), 'r') as cellexport, \
            open(os.path.join(args.routerdir, args.moduledict), 'r') as mapping, \
            open(os.path.join(args.routerdir, "results.txt"), 'w') as outfile:

        signal_module_map = eval(mapping.read())

        main(cellexport.name, signal_module_map, outfile, debug)
