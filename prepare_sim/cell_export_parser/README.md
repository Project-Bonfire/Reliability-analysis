# Cell Connection converter

This projects defines an antlr grammar and a listener to output all pins of all cells of a ams_syn?? export of all cells.

The output is simply a list of the names of all pins.

## Generating `cell_connections.txt`

To generate the `cell_connections.txt` file:
 - Open `Synopsys 2016 EDA version w/ AMS HITKIT 4.11 0.18um designkit` with `ams_syn`
 - Select `file->analyze` and choose the `.v` file (`Router_32_bit_credit_based_gate_level_without_hierarchy.v`)
 - Select `file->elaborate`
 - Select all cells
 - Mark all cells with `ctrl+a`
 - Right click, select report, select selection, select file to export, unmark print
 - Then Remove everything else which was printed to the file (Warnings and messages with `*`)


## Files
 - `Cells.g4` contains the grammar
 - `convert_to_pins.py` is the main file which runs the program
 - `test.txt` a small test example
 - `cell_connections.txt` is the last full export of all cells.

## Usage
    python convert_to_pins.py path_to_file > results.txt
