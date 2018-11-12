# Scenario Generator

Creates scenarios for the Reliability Analysis for NoC.

```
usage: scn_generator.py [-h] optionstr designfolder scnfile

Generates a scenariofile for processing a NoC router

positional arguments:
  optionstr     Options for the packet generators. Expected format is
                "<min_packet_length>,<max_packet_length> <frame_length>"
  designfolder  Folder where the currently analyzed design is located
  scnfile       Scenario file to be generated

optional arguments:
  -h, --help    show this help message and exit
```
