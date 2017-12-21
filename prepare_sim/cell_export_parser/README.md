# Cell Connection converter

This projects defines an antlr grammar and a listener to output all pins of all cells of a ams_syn?? export of all cells.

## Output
Each pin has its own line in the output.
each line consists of 3 columns:
    1. cellname
    2. pinname
    3. module where this pin belongs to: one of `lbdr,fifo,arbiter,xbar`

Pay attention to the stderr output for further information on module guessing.

## Generating `cell_connections.txt`

To generate the `cell_connections.txt` file:
 - Open `Synopsys 2016 EDA version w/ AMS HITKIT 4.11 0.18um designkit` with `ams_syn`
 - Select `file->analyze` and choose the `.v` file (`Router_32_bit_credit_based_gate_level_without_hierarchy.v`)
 - Select `file->elaborate`
 - Select all cells
 - Mark all cells with `ctrl+a`
 - Right click, select report, select selection, select file to export, untick append to file, untick to report viewer
 - If it thows errors: remove everything else which was printed to the file (Warnings and messages with `*`)
 - is also able to parse the verbose version of the output.
 - Make sure the file ends with an empty line. Parsing may fail because of that.


## Files
 - `Cells.g4` contains the grammar
 - `convert_to_pins.py` is the main file which runs the program
 - `test.txt` a small test example
 - `cell_connections.txt` is the last full export of all cells.

## Usage
    python convert_to_pins.py path_to_file > results.txt

## Reference Data
`{}` marks strings, so all lines can be wrapped in these.


    add wave -position insertpoint {sim/:tb_router:R_5:\FIFO_N/FIFO_seq/FIFO_MEM_1_reg[6] :*}
    add wave -position insertpoint {sim/:tb_router:R_5:\CONTROL_PART/LBDR_L/U50 :*}
    add wave -position insertpoint sim/:tb_router:R_5:U2994:*
    force -freeze {sim/:tb_router:R_5:\FIFO_N/FIFO_seq/FIFO_MEM_1_reg[6] :CP} St0 0
    force -freeze {sim/:tb_router:R_5:\CONTROL_PART/LBDR_L/U50 :A} St1 0
    force -freeze sim/:tb_router:R_5:U2994:A1 StX 0
    force -freeze sim/:tb_router:R_5:U2994:A2 St1 0