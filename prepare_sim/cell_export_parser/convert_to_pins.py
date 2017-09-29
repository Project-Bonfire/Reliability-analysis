import sys
from antlr4 import *

from CellsLexer import CellsLexer
from CellsListener import CellsListener
from CellsParser import CellsParser


class PinPrinter(CellsListener):
    def exitIoline(self, ctx):
        #unofrtunatley, for some reason, the pins are named differently, the only valid difference I found, is that the one without backslash are starting with U
        print(("" if str(ctx.parentCtx.parentCtx.children[0].children[0].children[1]).startswith("U") else "\\") + str(ctx.parentCtx.parentCtx.children[0].children[0].children[1]) + " :" + str(ctx.children[0]))

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
