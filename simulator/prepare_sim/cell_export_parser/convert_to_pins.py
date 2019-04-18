import argparse
import os
import re
import sys
from typing import Dict, List, Pattern

from antlr4 import *

from gen.CellsLexer import CellsLexer
from gen.CellsListener import CellsListener
from gen.CellsParser import CellsParser

RET_OK = 0
RET_ERR = 2
RET_DEBUG = 3

class CellParser(CellsListener):
    """
    Parses te parse tree and writes found pins and the information about their the modules 
    they belong to into the output file.
    """

    def __init__(self, debug_unknown):
        """
        :param
            debug_unknown - If True, the tool will print out the list of 
                            cells which cannot be assigned to any module
        """
        CellsListener.__init__(self)

        self.debug_unknown = debug_unknown

        self.total_cell_count = 0
        self.total_pin_count = 0
        self.cells_with_unknown_module = 0

        self.outstream = None
        self.signal_module_map = None
        self.fault_locs_per_module: Dict[str, int] = {}


    def exitCell(self, ctx: CellsParser.CellContext):
        """
        Processes a cell in the cell export file. Called when the ANTLR parser exits 
        a Cell node. Will process the cell and output all its pins with the name of 
        the module they belong to into an output file.

        :param
            ctx - Pointer to the cell to be processed in the ANTLR parse tree
        """
        self.total_cell_count += 1

        cell_module = None

        # Get the name of the current cell
        # r.cell.header.nameline.<name>
        cell_name = ctx.children[0].children[0].children[1].symbol.text

        # Ignore cells without module in their name (the likes of 'U37)
        if re.match('^U[0-9]+', cell_name):
            if self.debug_unknown:
                print(cell_name)

            self.cells_with_unknown_module += 1
            return

        # Try to match the cell name to a module
        for signal_regex, module_name in signal_module_map.items():
            if re.match(signal_regex, cell_name):
                cell_module = module_name
                break

        if cell_module == None:
            raise ValueError("Cannot find module for cell! Cell name is:", cell_name)

        # Extract all io_pins in the cell (outputs and inputs)
        # [r.cell.inputs.io_pin[0:n] + (r.cell.outputs.io_pin[0:n], if outputs exist)]
        if len(ctx.children) > 2:
            io_pins = ctx.children[1].children[7:] + ctx.children[2].children[7:]
        
        else:
            io_pins = ctx.children[1].children[7:]

        if io_pins == []:
            raise ValueError("Cell has no pins!", cell_name)

        # Iterate over pins connected to the cell and log them
        for io_pin in io_pins:

            pin_name = str(io_pin.children[0].children[0])
            
            if not pin_name in ('CP', 'RN'):
                self.total_pin_count += 1
            
                # Add pins to the module
                if cell_module in self.fault_locs_per_module:
                    self.fault_locs_per_module[cell_module] += 1

                else:
                    self.fault_locs_per_module[cell_module] = 1

                # Save the fault injection location to the output file
                print(pin_name)
                injection_location = "\\" + cell_name + " :" + pin_name + ' ' + '!' + cell_module + '\n'
                self.outstream.writelines(injection_location)

def main(cell_export_file, signal_module_map, outfile, debug_unknown, fault_info_file):
    """
    Parses the cell export file and prints results

    :param
        cell_export_file - path to the cell export file
        signal_module_map - map which maps different name patters to module names
        outfile - file where to write the output
        debug_unknown - If enabled, the tool will print out all cells which cannot be added into any module
    """
    # Setting up ANTLR environment for parsing the cell export
    print('Creating parse tree...')
    input_stream = FileStream(cell_export_file)
    lexer = CellsLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = CellsParser(stream)
    tree = parser.r()

    # Actually parse the cell export
    print('Parsing the cell export...')
    cell_parser = CellParser(debug_unknown)
    cell_parser.signal_module_map = signal_module_map
    cell_parser.outstream = outfile
    walker = ParseTreeWalker()
    walker.walk(cell_parser, tree)

    # Print statistics
    module_list = str(sorted(list(set(cell_parser.fault_locs_per_module.keys()))))

    print()
    print(11 * '-')
    print('STATISTICS:')
    print(11 * '-')
    print()

    print('Total number of cells:', cell_parser.total_cell_count)
    print('Could not determine modules for', cell_parser.cells_with_unknown_module, 
            'cells. (', round(cell_parser.cells_with_unknown_module * 100 / cell_parser.total_cell_count, 2), 
            '% of all cells) --> CELLS IGNORED')
    print('Those are probably cells which do not belong to any module. Use the --debug-unknown flag to list them')
    print('Total number of VALID fault injection locations:', cell_parser.total_pin_count)

    print()

    print('Detected modules:', module_list)

    print()
    print('Fault injection locations per module:')

    longest_module_name_length = 0

    for module in cell_parser.fault_locs_per_module.keys():
        if len(module) > longest_module_name_length:
            longest_module_name_length = len(module) + 1

    for module_name, fault_locs in sorted(cell_parser.fault_locs_per_module.items()):
        length_difference = longest_module_name_length - len(module_name)
        print('\t' + module_name + ':' + length_difference * ' ' + str(fault_locs))

    print()
    print(11 * '-')
    
    if fault_info_file:
        with open(fault_info_file, 'w') as fi:
            fi.writelines('modules=' + module_list + '\n')
            fi.writelines('nrfaultlocs=' + str(sum(cell_parser.fault_locs_per_module.values())) + '\n')
            fi.writelines('locspermodule=' + str(cell_parser.fault_locs_per_module) + '\n')


if __name__ == '__main__':

    if (sys.version_info < (3, 6)):
        print("This script is designed to run on Python 3.6 or newer!")
        exit(1)

    print()
    print('==================')
    print('CELL EXPORT PARSER')
    print('==================')

    args = argparse.ArgumentParser(
        description='Creates a list of Fault injection locations for a router.')

    args.add_argument('designdir', type=str,
                      help='The directory where the design is located.')

    args.add_argument('--cellexport', nargs='?', type=str, default="gatelevel/Cells_Report_Verbose.txt",
                      help='Filename of the cellexport file in the router folder (defaults to \'gatelevel/Cells_Report_Verbose.txt\')')

    args.add_argument('--fault-info-file', nargs='?', type=str, default=None,
                      help='A temporary, where to write the basic results in a machine readable format')

    args.add_argument('--results-file', nargs='?', type=str, default="generated_files/results.txt",
                      help='Filename where to write the results (defaults to \'generated_files/results.txt\')')

    args.add_argument('--moduledict', nargs='?', type=str, default="pattern_to_modules.py",
                      help='Name of the file, which contains the dictionary for mapping the patterns in the cell export to  module names'
                      '(defaults to \'pattern_to_modules.py\').')

    args.add_argument('--inputdict', nargs='?', type=str, default="inputs_to_modules.py",
                      help='Name of the file, which contains the dictionary for mapping the patterns in the cell export to  module names for module inputs'
                      '(defaults to \'pattern_to_modules.py\').')

    debug_args = args.add_mutually_exclusive_group()
    debug_args.add_argument('--debug-unknown', action='store_true',
                            help='Prints cells which cannot be assigned to a module')

    args = args.parse_args()

    with open(os.path.join(args.designdir, args.cellexport), 'r') as cellexport, \
            open(os.path.join(args.designdir, args.moduledict), 'r') as mapping, \
            open(os.path.join(args.designdir, args.inputdict), 'r') as input_mapping, \
            open(os.path.join(args.designdir, args.results_file), 'w') as outfile:

        module_map = eval(mapping.read())
        input_map = eval(input_mapping.read())

        signal_module_map = {**input_map, **module_map}

        main(cellexport.name, signal_module_map, outfile, args.debug_unknown, args.fault_info_file)

