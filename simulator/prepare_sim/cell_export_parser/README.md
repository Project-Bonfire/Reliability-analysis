# Cell Connection converter

This projects defines an antlr grammar and a listener to output all pins of all cells from the verbose cell export of a circuit.
The pins are then assigned to modules based on their names.

To be able to do the assignment correctly, a `pattern_to_modules.py` file has to be present in the router's folder.
This script mus contain a map from regular expressions to module names.
An example can be seen below:

```
{
    r'^valid_': 'arbiter',
    r'^CONTROL_PART/allocator_unit': 'arbiter',
    r'^allocator_unit': 'arbiter',
    r'^CONTROL_PART/LBDR': 'none',
    r'^CONTROL_PART/Req':'rtable',
    r'^CONTROL_PART/ROUTING_TABLE': 'rtable',
    r'^FIFO_[NESLW]/FIFO_CONTROL_PART': 'fifoc',
    r'^FIFO_[NESLW]/FIFO_DATA_PATH': 'fifod',
    r'^XBAR': 'xbar',
    r'^Xbar': 'xbar'
}
```

## Output
Each pin has its own line in the output.
each line consists of 3 columns:
    1. cellname
    2. pinname
    3. module where this pin belongs to: such as `lbdr,fifo,arbiter,xbar`

Pay attention to the stderr output for further information on module guessing.

## Generating the verbose cell export

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

    `python convert_to_pins.py <routerdir>`
    
    For additional arguments see the help of the script.

