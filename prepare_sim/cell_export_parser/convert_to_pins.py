import sys
from antlr4 import *

from gen.CellsLexer import CellsLexer
from gen.CellsListener import CellsListener
from gen.CellsParser import CellsParser


class PinPrinter(CellsListener):
    def exitIoline(self, ctx):
        """
        Example:
            Connections for cell 'U670': [...]
            Input Pins          Net            Net Driver Pins   Driver Pin Type
            ----------------    ------------   ----------------  ----------------
            A                   FIFO_N/n411    FIFO_N/U337/Q     Output Pin (XNOR2X6)
        :param ctx:
        :return:
        """
        # U670
        cellname = str(ctx.parentCtx.parentCtx.children[0].children[0].children[1])
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
        #ctx.children[1] ctx.children[3].children[0]
        #unofrtunatley, for some reason, the pins are named differently, the only valid difference I found, is that the one without backslash are starting with U
        print(("" if cellname.startswith("U") else "\\") + cellname + " :" + pinname + ' ' + netname + ' ' + str(pinlist))

def main(argv):
    input = FileStream(argv[1])
    lexer = CellsLexer(input)
    stream = CommonTokenStream(lexer)
    parser = CellsParser(stream)
    tree = parser.r()
    printer = PinPrinter()
    walker = ParseTreeWalker()
    walker.walk(printer, tree)



if __name__ == '__main__':
    main(sys.argv)
