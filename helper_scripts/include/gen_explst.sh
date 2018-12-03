#!/bin/sh
if [ "$1" = "" ];  then
    echo "Prints the list of experiments which have the given hash in design info file."
    echo ""
    echo "Usage: $0 <results_folder> <hash from designinfo>"
    exit
fi

cd $1
find ./*/designinfo.txt -exec sh -c "if cat {} | grep $2 > /dev/null; then echo -n ;dirname {} | cut -d/ -f 2; else :; fi" \; > $2.explst
