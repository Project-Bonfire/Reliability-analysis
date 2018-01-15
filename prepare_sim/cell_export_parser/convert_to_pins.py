import sys
from typing import List

from antlr4 import *

from gen.CellsLexer import CellsLexer
from gen.CellsListener import CellsListener
from gen.CellsParser import CellsParser
import re



def guessModule(cellname,netname,pinlist,ctx):
    """
    Guesses to which module the ioline belongs.
    :return: None,lbdr,fifo,arbiter,xbar
    """

    def guessComponent():

        try:
            if not netname.startswith('U') and not netname.startswith('n'):
                return netname

            res = [p[0] for p in pinlist if not p[0].startswith('U')]
            if res:
                return res[0]
            if not cellname.startswith('U'):
                return cellname
            return None
            #return str(ast.literal_eval(' '.join(splitted[3:]))[0][0])
        except ValueError as ve:
            print("Failed to guess component! %s" % cellname, file=sys.stderr)
            print(ctx,file=sys.stderr)

    typemap = {
        r'^valid_': 'arbiter',
        r'^CONTROL_PART/allocator_unit': 'arbiter',
        r'^allocator_unit': 'arbiter',
        r'^CONTROL_PART/LBDR': 'lbdr',
        r'^CONTROL_PART/Req':'lbdr',
        r'^CONTROL_PART/ROUTING_TABLE': 'lbdr',
        r'^FIFO_[NESLW]/FIFO_comb': 'fifoc',
        r'^FIFO_[NESLW]/FIFO_seq': 'fifod',
        r'^FIFO_[NESLWD]':'fifod',#fallback fifo
        r'^XBAR': 'xbar',
        r'^Xbar': 'xbar'
    }
    comp = guessComponent()
    if not comp:
        return None
    if comp == 'nofault':
        return None
    for k, v in typemap.items():
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

    def exitCell(self, ctx:CellsParser.CellContext):
        cellname = ctx.children[0].children[0].children[1].symbol.text
        iolines = ctx.children[1].children[7:] + ctx.children[2].children[7:]
        modules = []
        lines : List[Line]=[]
        #create one Line object for each ioline
        for line in  iolines:
            pinname,netname,pinlist = self.handleIOline(line)
            module = guessModule(cellname, netname, pinlist, ctx)
            if module != None:
                modules.append(module)
            lines.append(Line(cellname,pinname,netname,pinlist,module))

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
            print(("" if l.cellname.startswith("U") else "\\") + l.cellname + " :" + l.pinname + ' ' + '!'+l.module)




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


def main(argv):
    input = FileStream(argv[1])
    lexer = CellsLexer(input)
    stream = CommonTokenStream(lexer)
    parser = CellsParser(stream)
    tree = parser.r()
    printer = PinPrinter()
    walker = ParseTreeWalker()
    walker.walk(printer, tree)
    print("Had to choose 'fifo' as fallback module on %d lines, because I could not guess to which module the line belongs."%printer.module_fallback_counter,file=sys.stderr)



if __name__ == '__main__':
    main(sys.argv)
