# Cell Connection converter

This projects defines an antlr grammar and a listener to output all pins of all cells of a ams_syn?? export of all cells.

The output is simply a list of the names of all pins.

## Files
 - `Cells.g4` contains the grammar
 - `convert_to_pins.py` is the main file which runs the program
 - `test.txt` a small test example
 - `cell_connections.txt` is the last full export of all cells.

## Usage
    python convert_to_pins.py path_to_file > results.txt
