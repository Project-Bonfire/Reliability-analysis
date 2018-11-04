import os
import re
import sys
import argparse
from typing import List, Dict, Pattern

from antlr4 import *

from gen.CellsLexer import CellsLexer
from gen.CellsListener import CellsListener
from gen.CellsParser import CellsParser

class Wire:
    """
    Class to store data each IO line in the cell export
    """
    cell_name: str
    pin_name: str
    net_name: str
    pin_list: List[str]
    module: str

    def __init__(self, cell_name, pin_name, net_name, pin_list, module) -> None:
        super().__init__()
        self.cell_name = cell_name
        self.pin_list = pin_list
        self.net_name = net_name
        self.pin_name = pin_name
        self.module = module

class PinWriter(CellsListener):
    """
    Parses te parse tree and writes found pins into the output file
    """
    num_cells = 0
    multi_module_counter = 0
    module_fallback_counter = 0

    outstream = None
    signal_module_map = None

    fault_locs_per_module: Dict[str, Wire] = {}

    def exitCell(self, ctx: CellsParser.CellContext):
        """
        Called when the ANTLR parser exits a Cell node. 
        Will process the cell and output all its pins to the output file
        """
        iolines = []
        modules = []
        wires: List[Wire] = []

        self.num_cells += 1

        # Get the name of the current cell
        # r.cell.header.nameline.<name>
        cell_name = ctx.children[0].children[0].children[1].symbol.text

        # Extract all iolines in the cell (outputs and inputs)
        # [r.cell.inputs.ioline[0:n] + (r.cell.outputs[0:n], if outputs exist)]
        iolines = ctx.children[1].children[7:] + \
            (ctx.children[2].children[7:] if len(ctx.children) > 2 else [])

        # Create one Wire object for each ioline which is connected to the cell
        for ioline in iolines:
            pin_name, net_name, pin_list = self.handleIOline(ioline)
            module = guessModule(cell_name, net_name, pin_list,
                                 ctx, self.signal_module_map)

            

            if module != None:
                modules.append(module)

            # if not all(x == modules[0] for x in modules):
                # print([cell_name, pin_name, net_name, pin_list, module], '->', modules)#, file=sys.stderr)
            wires.append(Wire(cell_name, pin_name, net_name, pin_list, module))

        if len(set(modules)) > 1:
            self.multi_module_counter += 1

        ######################################################################################
        # THIS IS WHERE ALL THE IMPORTANT DECISIONS ABOUT WHICH WIRE GOES WHERE ARE MADE!!!! #
        ######################################################################################

        # Prefer the module name found directly in the ioline, but if the ioline had no module name, use one from the general cell.
        if modules:
            for ioline in wires:
                
                if ioline.module == None:
                    # print(modules, file=sys.stderr)
                    # if not all(x == modules[0] for x in modules):
                    # print([ioline.cell_name, ioline.pin_name, ioline.net_name, ioline.pin_list, ioline.module], '->', modules)#, file=sys.stderr)

                    ioline.module = modules[0]

        else:  # As fallback, we assign the cell to the fifo, when we cannot guess to which module it belongs.
            for ioline in wires:
                ioline.module = 'none'
                self.module_fallback_counter += 1

        # Unfortunately, for some reason, some of the pins are named differently. The only valid difference I found
        # is that the ones without backslash are starting with U

        # Counts the number of fault injection locations per module
        for ioline in wires:
            if ioline.module in self.fault_locs_per_module:
                self.fault_locs_per_module[ioline.module] += 1

            else:
                self.fault_locs_per_module[ioline.module] = 1

            print(("" if ioline.cell_name.startswith("U") else "\\") + ioline.cell_name +
                  " :" + ioline.pin_name + ' ' + '!' + ioline.module, file=self.outstream)

    def handleIOline(self, ctx):
        """
        Example:
            Connections for cell 'U670': [...]
            Input Pins          Net            Net Driver Pins   Driver Pin Type
            ----------------    ------------   ----------------  ----------------
            A                   FIFO_N/n411    FIFO_N/U337/Q     Output Pin (XNOR2X6)
        :param ctx:
        :return:
        """
        def conv_pin_type(node):
            if(len(node.children) >= 3):
                return str(node.children[0]) + '(' + str(node.children[2]) + ')'

            else:
                return str(node.children[0])

        # A
        pin_name = str(ctx.children[0].children[0])

        # FIFO_N/n411
        net_name = str(ctx.children[1].children[0] if not isinstance(
            ctx.children[1], TerminalNode) else 'None')

        # [ ( FIFO_N/U337/Q , Output Pin (XNOR2X6) ) ]

        pin_list = [(str(pin.children[1]), conv_pin_type(pin.children[3].children[0]))
                   for pin in ctx.children[2].children] if net_name is not 'None' else 'None'

        return pin_name, net_name, pin_list

def guessModule(cell_name, net_name, pin_list, ctx, signal_module_map):
    """
    Guesses to which module the io_line belongs to.
    :return: None,lbdr,fifo,arbiter,xbar
    """

    def guessComponent():

        try:
            
            res = []
            for pin in pin_list:
                if not pin[0].startswith('U') and \
                    not net_name.startswith('n') and \
                    not net_name == "reset":
                    res.append(pin[0])
                    # print(pin[0], net_name, file=sys.stderr)


            if res:
                # print(res, file=sys.stderr)
                return res[0]

            # Guess the component based on net name
            for signal_name, module_name in signal_module_map.items():
                if re.match(signal_name, net_name):
                    # print(signal_name, '->', net_name, file=sys.stderr)
                    return net_name
            if not cell_name.startswith('U'):
                return cell_name

            return None

            # return str(ast.literal_eval(' '.join(splitted[3:]))[0][0])
        except ValueError:
            print("Failed to guess component! %s" % cell_name, file=sys.stderr)
            print(ctx, file=sys.stderr)
  #
  #  signal_module_map = {
  #      r'^valid_': 'arbiter',
  #      r'^CONTROL_PART/allocator_unit': 'arbiter',
  #      r'^allocator_unit': 'arbiter',
  #      r'^CONTROL_PART/LBDR': 'lbdr',
  #      r'^CONTROL_PART/Req': 'lbdr',
  #      r'^CONTROL_PART/ROUTING_TABLE': 'lbdr',
  #      r'^FIFO_[NESLW]/FIFO_comb': 'fifoc',
  #      r'^FIFO_[NESLW]/FIFO_seq': 'fifod',
  #      r'^FIFO_[NESLWD]': 'fifod',  # fallback fifo
  #      r'^XBAR': 'xbar',
  #      r'^Xbar': 'xbar'
  #  }
    comp = guessComponent()
    if not comp:
        return None

    if comp == 'nofault':
        return None

    for signal, module in signal_module_map.items():
        if re.match(signal, comp):
            return module

    return None

def main(file_name, mapping: Dict[Pattern[str], str], outfile):
    # Setting up ANTLR environment for parsing the cell export
    print("Creating parse tree...", file=sys.stderr)
    input_stream = FileStream(file_name)
    lexer = CellsLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = CellsParser(stream)
    tree = parser.r()
    
    
    # ANTLR listener pattern 
    print("Parsing the cell export...", file=sys.stderr)
    printer = PinWriter()
    printer.signal_module_map = mapping
    printer.outstream = outfile
    walker = ParseTreeWalker()
    walker.walk(printer, tree)
    
    print("modules=%s" % str(list(set(printer.fault_locs_per_module.keys()))))
    print("nrfaultlocs=%d" % sum(printer.fault_locs_per_module.values()))
    print("fault_locs_per_module=%s" % str(printer.fault_locs_per_module))
    print("Had to choose 'none' as fallback module on %d wires, because I could not guess to which module the ioline belongs." %
          printer.module_fallback_counter)
    print("Had %d cells where I assigned the pins to multiple different modules. (%d total=%f%%)" % (
        printer.multi_module_counter, printer.num_cells, printer.multi_module_counter/printer.num_cells))


if __name__ == '__main__':

    print("==================", file=sys.stderr)
    print("CELL EXPORT PARSER", file=sys.stderr)
    print("==================", file=sys.stderr)

    parser = argparse.ArgumentParser(
        description='Creates a list of Fault injection locations for a router.')

    parser.add_argument('routerdir', type=str, help='The directory where the the router is located.')
    
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
