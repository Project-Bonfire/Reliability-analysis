# Generated from Cells.g4 by ANTLR 4.7
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .CellsParser import CellsParser
else:
    from CellsParser import CellsParser

# This class defines a complete listener for a parse tree produced by CellsParser.
class CellsListener(ParseTreeListener):

    # Enter a parse tree produced by CellsParser#r.
    def enterR(self, ctx:CellsParser.RContext):
        pass

    # Exit a parse tree produced by CellsParser#r.
    def exitR(self, ctx:CellsParser.RContext):
        pass


    # Enter a parse tree produced by CellsParser#cell.
    def enterCell(self, ctx:CellsParser.CellContext):
        pass

    # Exit a parse tree produced by CellsParser#cell.
    def exitCell(self, ctx:CellsParser.CellContext):
        pass


    # Enter a parse tree produced by CellsParser#header.
    def enterHeader(self, ctx:CellsParser.HeaderContext):
        pass

    # Exit a parse tree produced by CellsParser#header.
    def exitHeader(self, ctx:CellsParser.HeaderContext):
        pass


    # Enter a parse tree produced by CellsParser#nameline.
    def enterNameline(self, ctx:CellsParser.NamelineContext):
        pass

    # Exit a parse tree produced by CellsParser#nameline.
    def exitNameline(self, ctx:CellsParser.NamelineContext):
        pass


    # Enter a parse tree produced by CellsParser#ref.
    def enterRef(self, ctx:CellsParser.RefContext):
        pass

    # Exit a parse tree produced by CellsParser#ref.
    def exitRef(self, ctx:CellsParser.RefContext):
        pass


    # Enter a parse tree produced by CellsParser#lib.
    def enterLib(self, ctx:CellsParser.LibContext):
        pass

    # Exit a parse tree produced by CellsParser#lib.
    def exitLib(self, ctx:CellsParser.LibContext):
        pass


    # Enter a parse tree produced by CellsParser#inputs.
    def enterInputs(self, ctx:CellsParser.InputsContext):
        pass

    # Exit a parse tree produced by CellsParser#inputs.
    def exitInputs(self, ctx:CellsParser.InputsContext):
        pass


    # Enter a parse tree produced by CellsParser#outputs.
    def enterOutputs(self, ctx:CellsParser.OutputsContext):
        pass

    # Exit a parse tree produced by CellsParser#outputs.
    def exitOutputs(self, ctx:CellsParser.OutputsContext):
        pass


    # Enter a parse tree produced by CellsParser#ioline.
    def enterIoline(self, ctx:CellsParser.IolineContext):
        pass

    # Exit a parse tree produced by CellsParser#ioline.
    def exitIoline(self, ctx:CellsParser.IolineContext):
        pass


