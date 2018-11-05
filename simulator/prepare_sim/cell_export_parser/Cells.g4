
grammar Cells;
r  : NEWLINE* cell+  NEWLINE* ('1' NEWLINE)? EOF;
cell : NEWLINE* header NEWLINE* inputs? NEWLINE* outputs;
header : nameline NEWLINE ref  NEWLINE lib NEWLINE (area NEWLINE)? (touch NEWLINE)?;
nameline : 'Connections for cell \'' (Identifier|AlphaNum) '\':';
ref : 'Reference:' AlphaNum ;
lib : 'Library:' Identifier;
area: 'Area:' Num;
touch: 'dont_touch:' AlphaNum;

inputs : 'Input Pins' 'Net' ('Net Driver Pins' 'Driver Pin Type')? NEWLINE Dashes NEWLINE io_pin+;

outputs : 'Output Pins' 'Net' ('Net Load Pins' 'Load Pin Type')? NEWLINE Dashes NEWLINE io_pin+;

io_pin : pin_name (net_name connected_pins)? NEWLINE;
pin_name: AlphaNum;
net_name: (Identifier|AlphaNum);
connected_pins:  connected_pin+;
// added the newline parser rule here because the list indices change otherwise all the time, if using the tokenizer rule.
connected_pin: newline (Identifier|AlphaNum) newline pin_type newline;
newline: NEWLINE?;
pin_type : (input_pin|output_pin) ;
input_pin: ('Input Pin' '(' (Identifier|AlphaNum) ')' | 'Input Port');
output_pin: ('Output Pin' '(' (Identifier|AlphaNum) ')' | 'Output Port');

Dashes : [-]+ [ ]+ [-]+ ([ ]+ [-]+[ ]+ [-]+)?;

Num : [0-9.]+;
AlphaNum : [a-zA-Z0-9]+;
Identifier : ([a-zA-Z0-9]|'_'|'['|']'|'/'|'*')+;
COMMENT: '****************************************' NEWLINE  ~[*]+ '****************************************'  NEWLINE -> skip;
INFORMATIONLINE: 'Information:' ~('\n')+ -> skip;
WS : [ \t\r]+ -> skip ; 
NEWLINE             : ('\r'? '\n' | '\r')+ ;


