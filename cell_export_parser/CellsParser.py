# Generated from Cells.g4 by ANTLR 4.7
# encoding: utf-8
from antlr4 import *
from io import StringIO
from typing.io import TextIO
import sys

def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\16")
        buf.write("g\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b")
        buf.write("\t\b\4\t\t\t\4\n\t\n\3\2\7\2\26\n\2\f\2\16\2\31\13\2\3")
        buf.write("\2\6\2\34\n\2\r\2\16\2\35\3\2\7\2!\n\2\f\2\16\2$\13\2")
        buf.write("\3\3\7\3\'\n\3\f\3\16\3*\13\3\3\3\3\3\7\3.\n\3\f\3\16")
        buf.write("\3\61\13\3\3\3\3\3\7\3\65\n\3\f\3\16\38\13\3\3\3\3\3\3")
        buf.write("\4\3\4\3\4\3\4\3\4\3\4\3\4\3\5\3\5\3\5\3\5\3\6\3\6\3\6")
        buf.write("\3\7\3\7\3\7\3\b\3\b\3\b\3\b\3\b\3\b\6\bS\n\b\r\b\16\b")
        buf.write("T\3\t\3\t\3\t\3\t\3\t\3\t\6\t]\n\t\r\t\16\t^\3\n\3\n\5")
        buf.write("\nc\n\n\3\n\3\n\3\n\2\2\13\2\4\6\b\n\f\16\20\22\2\3\3")
        buf.write("\2\13\f\2f\2\27\3\2\2\2\4(\3\2\2\2\6;\3\2\2\2\bB\3\2\2")
        buf.write("\2\nF\3\2\2\2\fI\3\2\2\2\16L\3\2\2\2\20V\3\2\2\2\22`\3")
        buf.write("\2\2\2\24\26\7\16\2\2\25\24\3\2\2\2\26\31\3\2\2\2\27\25")
        buf.write("\3\2\2\2\27\30\3\2\2\2\30\33\3\2\2\2\31\27\3\2\2\2\32")
        buf.write("\34\5\4\3\2\33\32\3\2\2\2\34\35\3\2\2\2\35\33\3\2\2\2")
        buf.write("\35\36\3\2\2\2\36\"\3\2\2\2\37!\7\16\2\2 \37\3\2\2\2!")
        buf.write("$\3\2\2\2\" \3\2\2\2\"#\3\2\2\2#\3\3\2\2\2$\"\3\2\2\2")
        buf.write("%\'\7\16\2\2&%\3\2\2\2\'*\3\2\2\2(&\3\2\2\2()\3\2\2\2")
        buf.write(")+\3\2\2\2*(\3\2\2\2+/\5\6\4\2,.\7\16\2\2-,\3\2\2\2.\61")
        buf.write("\3\2\2\2/-\3\2\2\2/\60\3\2\2\2\60\62\3\2\2\2\61/\3\2\2")
        buf.write("\2\62\66\5\16\b\2\63\65\7\16\2\2\64\63\3\2\2\2\658\3\2")
        buf.write("\2\2\66\64\3\2\2\2\66\67\3\2\2\2\679\3\2\2\28\66\3\2\2")
        buf.write("\29:\5\20\t\2:\5\3\2\2\2;<\5\b\5\2<=\7\16\2\2=>\5\n\6")
        buf.write("\2>?\7\16\2\2?@\5\f\7\2@A\7\16\2\2A\7\3\2\2\2BC\7\3\2")
        buf.write("\2CD\t\2\2\2DE\7\4\2\2E\t\3\2\2\2FG\7\5\2\2GH\7\13\2\2")
        buf.write("H\13\3\2\2\2IJ\7\6\2\2JK\7\f\2\2K\r\3\2\2\2LM\7\7\2\2")
        buf.write("MN\7\b\2\2NO\7\16\2\2OP\7\n\2\2PR\7\16\2\2QS\5\22\n\2")
        buf.write("RQ\3\2\2\2ST\3\2\2\2TR\3\2\2\2TU\3\2\2\2U\17\3\2\2\2V")
        buf.write("W\7\t\2\2WX\7\b\2\2XY\7\16\2\2YZ\7\n\2\2Z\\\7\16\2\2[")
        buf.write("]\5\22\n\2\\[\3\2\2\2]^\3\2\2\2^\\\3\2\2\2^_\3\2\2\2_")
        buf.write("\21\3\2\2\2`b\7\13\2\2ac\t\2\2\2ba\3\2\2\2bc\3\2\2\2c")
        buf.write("d\3\2\2\2de\7\16\2\2e\23\3\2\2\2\13\27\35\"(/\66T^b")
        return buf.getvalue()


class CellsParser ( Parser ):

    grammarFileName = "Cells.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ "<INVALID>", "'Connections for cell ''", "'':'", "'Reference:'", 
                     "'Library:'", "'Input Pins'", "'Net'", "'Output Pins'" ]

    symbolicNames = [ "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                      "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                      "Dashes", "AlphaNum", "Identifier", "WS", "NEWLINE" ]

    RULE_r = 0
    RULE_cell = 1
    RULE_header = 2
    RULE_nameline = 3
    RULE_ref = 4
    RULE_lib = 5
    RULE_inputs = 6
    RULE_outputs = 7
    RULE_ioline = 8

    ruleNames =  [ "r", "cell", "header", "nameline", "ref", "lib", "inputs", 
                   "outputs", "ioline" ]

    EOF = Token.EOF
    T__0=1
    T__1=2
    T__2=3
    T__3=4
    T__4=5
    T__5=6
    T__6=7
    Dashes=8
    AlphaNum=9
    Identifier=10
    WS=11
    NEWLINE=12

    def __init__(self, input:TokenStream, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.7")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None



    class RContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def NEWLINE(self, i:int=None):
            if i is None:
                return self.getTokens(CellsParser.NEWLINE)
            else:
                return self.getToken(CellsParser.NEWLINE, i)

        def cell(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(CellsParser.CellContext)
            else:
                return self.getTypedRuleContext(CellsParser.CellContext,i)


        def getRuleIndex(self):
            return CellsParser.RULE_r

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterR" ):
                listener.enterR(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitR" ):
                listener.exitR(self)




    def r(self):

        localctx = CellsParser.RContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_r)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 21
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,0,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    self.state = 18
                    self.match(CellsParser.NEWLINE) 
                self.state = 23
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,0,self._ctx)

            self.state = 25 
            self._errHandler.sync(self)
            _alt = 1
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt == 1:
                    self.state = 24
                    self.cell()

                else:
                    raise NoViableAltException(self)
                self.state = 27 
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,1,self._ctx)

            self.state = 32
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CellsParser.NEWLINE:
                self.state = 29
                self.match(CellsParser.NEWLINE)
                self.state = 34
                self._errHandler.sync(self)
                _la = self._input.LA(1)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class CellContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def header(self):
            return self.getTypedRuleContext(CellsParser.HeaderContext,0)


        def inputs(self):
            return self.getTypedRuleContext(CellsParser.InputsContext,0)


        def outputs(self):
            return self.getTypedRuleContext(CellsParser.OutputsContext,0)


        def NEWLINE(self, i:int=None):
            if i is None:
                return self.getTokens(CellsParser.NEWLINE)
            else:
                return self.getToken(CellsParser.NEWLINE, i)

        def getRuleIndex(self):
            return CellsParser.RULE_cell

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterCell" ):
                listener.enterCell(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitCell" ):
                listener.exitCell(self)




    def cell(self):

        localctx = CellsParser.CellContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_cell)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 38
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CellsParser.NEWLINE:
                self.state = 35
                self.match(CellsParser.NEWLINE)
                self.state = 40
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 41
            self.header()
            self.state = 45
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CellsParser.NEWLINE:
                self.state = 42
                self.match(CellsParser.NEWLINE)
                self.state = 47
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 48
            self.inputs()
            self.state = 52
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==CellsParser.NEWLINE:
                self.state = 49
                self.match(CellsParser.NEWLINE)
                self.state = 54
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 55
            self.outputs()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class HeaderContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def nameline(self):
            return self.getTypedRuleContext(CellsParser.NamelineContext,0)


        def NEWLINE(self, i:int=None):
            if i is None:
                return self.getTokens(CellsParser.NEWLINE)
            else:
                return self.getToken(CellsParser.NEWLINE, i)

        def ref(self):
            return self.getTypedRuleContext(CellsParser.RefContext,0)


        def lib(self):
            return self.getTypedRuleContext(CellsParser.LibContext,0)


        def getRuleIndex(self):
            return CellsParser.RULE_header

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterHeader" ):
                listener.enterHeader(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitHeader" ):
                listener.exitHeader(self)




    def header(self):

        localctx = CellsParser.HeaderContext(self, self._ctx, self.state)
        self.enterRule(localctx, 4, self.RULE_header)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 57
            self.nameline()
            self.state = 58
            self.match(CellsParser.NEWLINE)
            self.state = 59
            self.ref()
            self.state = 60
            self.match(CellsParser.NEWLINE)
            self.state = 61
            self.lib()
            self.state = 62
            self.match(CellsParser.NEWLINE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class NamelineContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def Identifier(self):
            return self.getToken(CellsParser.Identifier, 0)

        def AlphaNum(self):
            return self.getToken(CellsParser.AlphaNum, 0)

        def getRuleIndex(self):
            return CellsParser.RULE_nameline

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterNameline" ):
                listener.enterNameline(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitNameline" ):
                listener.exitNameline(self)




    def nameline(self):

        localctx = CellsParser.NamelineContext(self, self._ctx, self.state)
        self.enterRule(localctx, 6, self.RULE_nameline)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 64
            self.match(CellsParser.T__0)
            self.state = 65
            _la = self._input.LA(1)
            if not(_la==CellsParser.AlphaNum or _la==CellsParser.Identifier):
                self._errHandler.recoverInline(self)
            else:
                self._errHandler.reportMatch(self)
                self.consume()
            self.state = 66
            self.match(CellsParser.T__1)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class RefContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def AlphaNum(self):
            return self.getToken(CellsParser.AlphaNum, 0)

        def getRuleIndex(self):
            return CellsParser.RULE_ref

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterRef" ):
                listener.enterRef(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitRef" ):
                listener.exitRef(self)




    def ref(self):

        localctx = CellsParser.RefContext(self, self._ctx, self.state)
        self.enterRule(localctx, 8, self.RULE_ref)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 68
            self.match(CellsParser.T__2)
            self.state = 69
            self.match(CellsParser.AlphaNum)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class LibContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def Identifier(self):
            return self.getToken(CellsParser.Identifier, 0)

        def getRuleIndex(self):
            return CellsParser.RULE_lib

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLib" ):
                listener.enterLib(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLib" ):
                listener.exitLib(self)




    def lib(self):

        localctx = CellsParser.LibContext(self, self._ctx, self.state)
        self.enterRule(localctx, 10, self.RULE_lib)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 71
            self.match(CellsParser.T__3)
            self.state = 72
            self.match(CellsParser.Identifier)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class InputsContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def NEWLINE(self, i:int=None):
            if i is None:
                return self.getTokens(CellsParser.NEWLINE)
            else:
                return self.getToken(CellsParser.NEWLINE, i)

        def Dashes(self):
            return self.getToken(CellsParser.Dashes, 0)

        def ioline(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(CellsParser.IolineContext)
            else:
                return self.getTypedRuleContext(CellsParser.IolineContext,i)


        def getRuleIndex(self):
            return CellsParser.RULE_inputs

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterInputs" ):
                listener.enterInputs(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitInputs" ):
                listener.exitInputs(self)




    def inputs(self):

        localctx = CellsParser.InputsContext(self, self._ctx, self.state)
        self.enterRule(localctx, 12, self.RULE_inputs)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 74
            self.match(CellsParser.T__4)
            self.state = 75
            self.match(CellsParser.T__5)
            self.state = 76
            self.match(CellsParser.NEWLINE)
            self.state = 77
            self.match(CellsParser.Dashes)
            self.state = 78
            self.match(CellsParser.NEWLINE)
            self.state = 80 
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while True:
                self.state = 79
                self.ioline()
                self.state = 82 
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if not (_la==CellsParser.AlphaNum):
                    break

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class OutputsContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def NEWLINE(self, i:int=None):
            if i is None:
                return self.getTokens(CellsParser.NEWLINE)
            else:
                return self.getToken(CellsParser.NEWLINE, i)

        def Dashes(self):
            return self.getToken(CellsParser.Dashes, 0)

        def ioline(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(CellsParser.IolineContext)
            else:
                return self.getTypedRuleContext(CellsParser.IolineContext,i)


        def getRuleIndex(self):
            return CellsParser.RULE_outputs

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterOutputs" ):
                listener.enterOutputs(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitOutputs" ):
                listener.exitOutputs(self)




    def outputs(self):

        localctx = CellsParser.OutputsContext(self, self._ctx, self.state)
        self.enterRule(localctx, 14, self.RULE_outputs)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 84
            self.match(CellsParser.T__6)
            self.state = 85
            self.match(CellsParser.T__5)
            self.state = 86
            self.match(CellsParser.NEWLINE)
            self.state = 87
            self.match(CellsParser.Dashes)
            self.state = 88
            self.match(CellsParser.NEWLINE)
            self.state = 90 
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while True:
                self.state = 89
                self.ioline()
                self.state = 92 
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if not (_la==CellsParser.AlphaNum):
                    break

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class IolineContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def AlphaNum(self, i:int=None):
            if i is None:
                return self.getTokens(CellsParser.AlphaNum)
            else:
                return self.getToken(CellsParser.AlphaNum, i)

        def NEWLINE(self):
            return self.getToken(CellsParser.NEWLINE, 0)

        def Identifier(self):
            return self.getToken(CellsParser.Identifier, 0)

        def getRuleIndex(self):
            return CellsParser.RULE_ioline

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterIoline" ):
                listener.enterIoline(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitIoline" ):
                listener.exitIoline(self)




    def ioline(self):

        localctx = CellsParser.IolineContext(self, self._ctx, self.state)
        self.enterRule(localctx, 16, self.RULE_ioline)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 94
            self.match(CellsParser.AlphaNum)
            self.state = 96
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if _la==CellsParser.AlphaNum or _la==CellsParser.Identifier:
                self.state = 95
                _la = self._input.LA(1)
                if not(_la==CellsParser.AlphaNum or _la==CellsParser.Identifier):
                    self._errHandler.recoverInline(self)
                else:
                    self._errHandler.reportMatch(self)
                    self.consume()


            self.state = 98
            self.match(CellsParser.NEWLINE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx





