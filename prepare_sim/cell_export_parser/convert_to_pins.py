import argparse
import sys
from typing import List, Dict, Pattern

from antlr4 import *
import os

from gen.CellsLexer import CellsLexer
from gen.CellsListener import CellsListener
from gen.CellsParser import CellsParser
import re



def guessModule(cellname,netname,pinlist,ctx,router_module_mapping):
    """
    Guesses to which module the ioline belongs.
    :return: None,lbdr,fifo,arbiter,xbar
    """

    def guessComponent():

        try:
            for k, v in router_module_mapping.items():
                if re.match(k, netname):
                    return netname
            res = [p[0] for p in pinlist if not p[0].startswith('U') and not netname.startswith('n') and not netname == "reset"]
            if res:
                return res[0]
            if not cellname.startswith('U'):
                return cellname
            return None
            #return str(ast.literal_eval(' '.join(splitted[3:]))[0][0])
        except ValueError as ve:
            print("Failed to guess component! %s" % cellname, file=sys.stderr)
            print(ctx,file=sys.stderr)
  #
  #  router_module_mapping = {
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
    for k, v in router_module_mapping.items():
        if re.match(k, comp):
            return v
    return None

class Line:
    cellname:str
    pinname:str
    netname:str
    pinlist:List[str]
    module:str

    def __init__(self,cellname,pinname,netname,pinlist,module) -> None:
        super().__init__()
        self.cellname = cellname
        self.pinlist = pinlist
        self.netname = netname
        self.pinname = pinname
        self.module = module


class PinPrinter(CellsListener):
    module_fallback_counter = 0
    multi_module_counter = 0
    num_cells = 0
    router_module_mapping=  None
    locspermodule : Dict[str,Line]= {}
    outstream=None

    def exitCell(self, ctx:CellsParser.CellContext):
        self.num_cells += 1
        cellname = ctx.children[0].children[0].children[1].symbol.text
        iolines=[]
        iolines = ctx.children[1].children[7:] + (ctx.children[2].children[7:] if len (ctx.children) > 2 else [])
        modules = []
        lines : List[Line]=[]
        #create one Line object for each ioline
        for line in  iolines:
            pinname,netname,pinlist = self.handleIOline(line)
            module = guessModule(cellname, netname, pinlist, ctx,self.router_module_mapping)
            if module != None:
                modules.append(module)
            lines.append(Line(cellname,pinname,netname,pinlist,module))
        if len(set(modules)) > 1:
            self.multi_module_counter += 1
        #sanitize modules in lines now.
        #prefer the module found directly in the line, but if the line had no module, use one from the general cell.
        if modules:
            for l in lines:
                if l.module == None:
                    l.module=modules[0]
        else:# as fallback, we assign the cell to the fifo, when we cannot guess to which module it belongs.
            for l in lines:
                l.module='none'
                self.module_fallback_counter += 1

        # unfortunatley, for some reason, the pins are named differently, the only valid difference I found, is that the one without backslash are starting with U
        for l in lines:
            if l.module in self.locspermodule:
                self.locspermodule[l.module] += 1
            else:
                self.locspermodule[l.module] = 1
            print(("" if l.cellname.startswith("U") else "\\") + l.cellname + " :" + l.pinname + ' ' + '!'+l.module,file=self.outstream)




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
        # A
        pinname = str(ctx.children[0].children[0])
        # FIFO_N/n411
        netname = str(ctx.children[1].children[0] if not isinstance(ctx.children[1],TerminalNode) else 'None')
        def conv_pin_type(node):
            if(len(node.children)>=3):
                return str(node.children[0]) + '('+str(node.children[2])+')'
            else:
                return str(node.children[0])
        # [ ( FIFO_N/U337/Q , Output Pin (XNOR2X6) ) ]
        pinlist = [(str(pin.children[1]), conv_pin_type(pin.children[3].children[0])) for pin in ctx.children[2].children] if netname is not 'None' else 'None'
        return pinname,netname,pinlist


def main(filename,mapping:Dict[Pattern[str],str],outfile):
    input = FileStream(filename)
    lexer = CellsLexer(input)
    stream = CommonTokenStream(lexer)
    parser = CellsParser(stream)
    tree = parser.r()
    printer = PinPrinter()
    printer.router_module_mapping=mapping
    printer.outstream=outfile
    walker = ParseTreeWalker()
    walker.walk(printer, tree)
    print("modules=%s"%str(list(set(printer.locspermodule.keys()))))
    print("nrfaultlocs=%d" % printer.num_cells)
    print("locspermodule=%s" % str(printer.locspermodule))
    print("Had to choose 'none' as fallback module on %d lines, because I could not guess to which module the line belongs."%printer.module_fallback_counter)
    print("Had %d cells where I assigned the pins to multiple different modules. (%d total=%f%%)"%(printer.multi_module_counter,printer.num_cells,printer.multi_module_counter/printer.num_cells))



if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Creates a list of Fault injection locations for a router.')
    parser.add_argument('routerdir', type=str, help='The dir of the router.')
    parser.add_argument('--cellexport', nargs='?', type=str, default="Cells_Report_Verbose.txt", help='filename of the cellexport in the folder')
    parser.add_argument('--moduledict', nargs='?', type=str, default="pattern_to_modules.py",
                        help='Filename of the patter to module file, which contains the dict.')
    args = parser.parse_args()
    with open(os.path.join(args.routerdir,args.cellexport), 'r') as cellexport,open(os.path.join(args.routerdir,args.moduledict), 'r') as mapping, open(os.path.join(args.routerdir,"results.txt"), 'w') as outfile:
        router_module_mapping = eval(mapping.read())

        main(cellexport.name,router_module_mapping,outfile)
