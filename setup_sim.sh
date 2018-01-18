 #!/bin/sh
 if [ "$1" = "" ];  then
    echo "Usage: $0 <routername in simulation/routers>"
    exit
fi
params="simulation/routers/$1/"
if [ ! -d "$params" ]; then
  echo "Error: router '$1' does not exist in 'simulation/routers'."
  echo ""
  echo "The following routers do exist:"
  ls simulation/routers
  echo ""
  echo "Usage: $0 <routername in simulation/routers>"
  exit
fi
 if [ "$2" != "" ];  then
    params+=" --cellexport $2"
fi

 ~/anaconda3/envs/mtt/bin/python prepare_sim/cell_export_parser/convert_to_pins.py $params
