#!/bin/tcsh -f
set scenario=mktemp

set packetlengths="3,3"
set framelength=50
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario

set packetlengths="3,3"
set framelength=100
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario

set packetlengths="3,3"
set framelength=200
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario

set packetlengths="3,3"
set framelength=400
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario

set packetlengths="3,3"
set framelength=800
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario



set packetlengths="8,8"
set framelength=100
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario


set packetlengths="8,8"
set framelength=200
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario


set packetlengths="8,8"
set framelength=400
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario


set packetlengths="8,8"
set framelength=800
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario

set packetlengths="15,15"
set framelength=200
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario

set packetlengths="15,15"
set framelength=400
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario

set packetlengths="15,15"
set framelength=800
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario

set packetlengths="20,20"
set framelength=200
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario

set packetlengths="20,20"
set framelength=400
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario

set packetlengths="20,20"
set framelength=800
python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength >> $scenario
./prepare_sim.sh 10000
./run_sim.sh $scenario
