#!/bin/bash

# run this in the same directory as parminion.sh
# gives info about what's happening

while true ; do

    clear;

    du -sh .

    NBMINIONDONE=$(ls *.minion.done 2> /dev/null | wc -l)
    echo "Number of *.minion.done files : $NBMINIONDONE"

    NBMINION=$(ls *.minion 2> /dev/null | wc -l)
    echo "Number of *.minion files      : $NBMINION"

    NBSOL=$(cat *.solutions 2> /dev/null | wc -l)
    echo "Number of solutions so far    : $NBSOL"

    echo "Best solution so far:"
    cat *.solutions | sort -n

    sleep 20;

done;
