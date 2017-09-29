
grammar Cells;
r  : NEWLINE* cell+  NEWLINE*;        
cell : NEWLINE* header NEWLINE* inputs NEWLINE* outputs; 
header : nameline NEWLINE ref  NEWLINE lib NEWLINE;
nameline : 'Connections for cell \'' (Identifier|AlphaNum) '\':';
ref : 'Reference:' AlphaNum ;
lib : 'Library:' Identifier;

inputs : 'Input Pins' 'Net'  NEWLINE Dashes NEWLINE ioline+;

outputs : 'Output Pins' 'Net' NEWLINE Dashes NEWLINE ioline+;

ioline : AlphaNum (Identifier|AlphaNum)? NEWLINE;

Dashes : [-]+ [ ]+ [-]+;

AlphaNum : [a-zA-Z0-9]+;
Identifier : ([a-zA-Z0-9]|'_'|'['|']'|'/')+;
WS : [ \t\r]+ -> skip ; 
NEWLINE             : ('\r'? '\n' | '\r')+ ;
