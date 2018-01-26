#!/bin/sh
if [ "$1" = "" ];  then
    echo "Prints the list of experiments which have the given pattern in its rti. Use the description or the number of fault locs. Should be unique."
    echo ""
    echo "Usage: $0 <pattern from rti>"
    exit
fi
cd results
find ./*/routerinfo.rti -exec sh -c "if cat {} | grep $1 > /dev/null; then echo -n results/;dirname {}; else :; fi" \;
