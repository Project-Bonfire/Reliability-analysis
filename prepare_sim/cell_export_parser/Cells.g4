
grammar Cells;
r  : NEWLINE* cell+  NEWLINE* EOF;
cell : NEWLINE* header NEWLINE* inputs NEWLINE* outputs; 
header : nameline NEWLINE ref  NEWLINE lib NEWLINE (area NEWLINE)? (touch NEWLINE)?;
nameline : 'Connections for cell \'' (Identifier|AlphaNum) '\':';
ref : 'Reference:' AlphaNum ;
lib : 'Library:' Identifier;
area: 'Area:' Num;
touch: 'dont_touch:' AlphaNum;

inputs : 'Input Pins' 'Net' ('Net Driver Pins' 'Driver Pin Type')? NEWLINE Dashes NEWLINE ioline+;

outputs : 'Output Pins' 'Net' ('Net Load Pins' 'Load Pin Type')? NEWLINE Dashes NEWLINE ioline+;

ioline : pinname (netname pins)? NEWLINE;
pinname: AlphaNum;
netname: (Identifier|AlphaNum);
pins:  pin+;
// added the newline parser rule here because the list indices change otherwise all the time, if using the tokenizer rule.
pin: newline (Identifier|AlphaNum) newline pintype newline;
newline: NEWLINE?;
pintype : (inputpin|outputpin) ;
inputpin: ('Input Pin' '(' (Identifier|AlphaNum) ')' | 'Input Port');
outputpin: ('Output Pin' '(' (Identifier|AlphaNum) ')' | 'Output Port');

Dashes : [-]+ [ ]+ [-]+ ([ ]+ [-]+[ ]+ [-]+)?;

Num : [0-9.]+;
AlphaNum : [a-zA-Z0-9]+;
Identifier : ([a-zA-Z0-9]|'_'|'['|']'|'/')+;
COMMENT: '****************************************' NEWLINE  ~[*]+ '****************************************'  NEWLINE -> skip;
INFORMATIONLINE: 'Information:' ~('\n')+ -> skip;
WS : [ \t\r]+ -> skip ; 
NEWLINE             : ('\r'? '\n' | '\r')+ ;


