import os
import re
import sys
import argparse
from typing import List, Dict, Pattern

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
        super().__init__()
        self.module = module
        self.net_name = net_name
        self.pin_name = pin_name
        self.cell_name = cell_name
        self.connected_pins = connected_pins


class PinWriter(CellsListener):
    """
    Parses te parse tree and writes found pins into the output file
    """
    num_cells = 0
    multi_module_counter = 0
    module_fallback_counter = 0

    named_as_none_counter = 0
    named_after_net_counter = 0
    named_after_cell_counter = 0
    named_after_connected_pins_counter = 0
    named_after_signal_module_map_counter = 0
    module_guess_counter = 0

    outstream = None
    signal_module_map = None

    fault_locs_per_module: Dict[str, Pin] = {}

    def exitCell(self, ctx: CellsParser.CellContext):
        """
        Called when the ANTLR parser exits a Cell node. 
        Will process the cell and output all its pins to the output file
        """
        modules = []
        io_pins = []
        pins: List[Pin] = []

        self.num_cells += 1

        ######################################################################################
        # THIS IS WHERE ALL THE IMPORTANT DECISIONS ABOUT WHICH Pin GOES WHERE ARE MADE!!!! #
        ######################################################################################

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
            module = self.guessModule(cell_name, net_name, connected_pins,
                                      ctx, self.signal_module_map)

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
        Example:
            Connections for cell 'U670': [...]
            Input pins          Net            Net Driver pins   Driver Pin Type
            ----------------    ------------   ----------------  ----------------
            A                   FIFO_N/n411    FIFO_N/U337/Q     Output Pin (XNOR2X6)
        :param ctx (r.cell.inputs.io_pin[n]):
        :return:
        """
        def conv_pin_type(node):
            """
            :param node - r.cell.inputs.io_pin[n].connected_pins[0:n].pin_type.<type_name>
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

    def guessModule(self, cell_name, net_name, connected_pins, ctx, signal_module_map):
        """
        Guesses to which module the io_line belongs to.
        :return: None,lbdr,fifo,arbiter,xbar
        """

        def guessComponent():
            """
            Tries to guess a components the pin belongs to
            returns [component name, 
            """

            try:
                connected_pin_names = []

                # Try to guess the module based on the nameline in the cell header
                if not cell_name.startswith('U'):
                    for signal, module in signal_module_map.items():
                        if re.match(signal, cell_name):
                            self.named_after_cell_counter += 1
                            return cell_name

                # Try to guess the component based on the rules specified in signal_module_map.
                for signal_name, module_name in signal_module_map.items():
                    if re.match(signal_name, net_name):
                        self.named_after_signal_module_map_counter += 1
                        return net_name

                # List all pins connected to the current pin
                for pin in connected_pins:
                    # pin[0] = r.cell.inputs.io_pin[n].connected_pins[0:n].<name>
                    # Ex: CONTROL_PART/allocator_unit/arb_X_L/U28/B
                    if not pin[0].startswith('U') and \
                            not net_name.startswith('n') and \
                            not net_name == "reset":
                        connected_pin_names.append(pin[0])

                # Choose the first pin for component detection.
                if connected_pin_names:
                    self.named_after_connected_pins_counter += 1
                    return connected_pin_names[0]

                self.named_as_none_counter += 1
                return None

            except ValueError:
                print("Failed to guess component! %s" %
                      cell_name, file=sys.stderr)
                print(ctx, file=sys.stderr)

        comp = guessComponent()
        if not comp:
            return None

        if comp == 'nofault':
            return None

        # Check if component fits any of the conditions for signals set in the signal condition map
        for signal, module in signal_module_map.items():
            if re.match(signal, comp):
                return module

        return None


def main(file_name, mapping: Dict[Pattern[str], str], outfile):
    # Setting up ANTLR environment for parsing the cell export
    print('Creating parse tree...', file=sys.stderr)
    input_stream = FileStream(file_name)
    lexer = CellsLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = CellsParser(stream)
    tree = parser.r()

    # Actually parse the cell export
    print('Parsing the cell export...', file=sys.stderr)
    printer = PinWriter()
    printer.signal_module_map = mapping
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

    print('Total number of fault injection locations:', total_fault_injection_locs)
    
    print()
    print('Detected modules:', str(list(set(printer.fault_locs_per_module.keys()))))

    print()
    print('Fault injection locations per module:')

    longest_module_name_length = 0
    for module in printer.fault_locs_per_module.keys():
        if len(module) > longest_module_name_length:
            longest_module_name_length = len(module) + 1

    for module_name, fault_locs in sorted(printer.fault_locs_per_module.items()):
        length_difference = longest_module_name_length - len(module_name)
        print('\t' + module_name + ':' +
              length_difference * ' ' + str(fault_locs))

    print()
    print('Pins were assigned to modules according the following data:')
    print('\tCell name:         %d\t(%f%%)' % (printer.named_after_cell_counter,
                                              printer.named_after_cell_counter * 100 / total_fault_injection_locs))

    print('\tSignal-module map: %d\t(%f%%)' % (printer.named_after_signal_module_map_counter,
                                              printer.named_after_signal_module_map_counter * 100 / total_fault_injection_locs))

    print('\tConnected pins:    %d\t(%f%%)' % (printer.named_after_connected_pins_counter,
                                              printer.named_after_connected_pins_counter * 100 / total_fault_injection_locs))

    print('\tNo name found:     %d\t(%f%%)' % (printer.named_as_none_counter,
                                              printer.named_as_none_counter * 100 / total_fault_injection_locs))

    print('Had to semi-randomly guess the module for %d pins. (%f%%)' % (printer.module_guess_counter,
                                                                         printer.module_guess_counter * 100 / total_fault_injection_locs))

    print()
    print('Pins were assigned to multiple different modules for %d cells. (%d total = %f%%)' % (
        printer.multi_module_counter, printer.num_cells, printer.multi_module_counter/printer.num_cells))

    if (printer.named_after_cell_counter + printer.named_after_signal_module_map_counter) < total_fault_injection_locs:
        print()
        print('W A R N I N G ! - Not all modules for pins were detected from the cell name or signal-module map! '
                'This means you might want to make sure all logic in your design is located under respective submodules. '
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
        exit (1)

    print()
    print('==================', file=sys.stderr)
    print('CELL EXPORT PARSER', file=sys.stderr)
    print('==================', file=sys.stderr)

    parser = argparse.ArgumentParser(
        description='Creates a list of Fault injection locations for a router.')

    parser.add_argument('routerdir', type=str,
                        help='The directory where the the router is located.')

    parser.add_argument('--cellexport', nargs='?', type=str, default="Cells_Report_Verbose.txt",
                        help='Filename of the cellexport file in the router folder (defaults to \'Cells_Report_Verbose.txt\')')

    parser.add_argument('--moduledict', nargs='?', type=str, default="pattern_to_modules.py",
                        help='Name of the file, which contains the dictionary for mapping the patterns in the cell export to  module names'
                        '(defaults to \'pattern_to_modules.py\').')

    args = parser.parse_args()

    with open(os.path.join(args.routerdir, args.cellexport), 'r') as cellexport, \
            open(os.path.join(args.routerdir, args.moduledict), 'r') as mapping, \
            open(os.path.join(args.routerdir, "results.txt"), 'w') as outfile:

        signal_module_map = eval(mapping.read())

        main(cellexport.name, signal_module_map, outfile)
