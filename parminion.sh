#!/bin/bash

# What is this script?

# put a single *.minion file in a directory, and call this from within that directory.
# (remove -findallsols if you don't need it.)

# Takes 3 arguments.
#   Arg1: number of cores to use
#   Arg2: how many seconds before a split (when number of *.minion files < number of cores)
#   Arg3: how many seconds before a split (when number of *.minion files >= number of cores)


NBCORES="$1"
SHORT="$2"
LONGER="$3"

MINIONS=$(ls *.minion 2> /dev/null)
NBMINIONS=$(ls *.minion 2> /dev/null | wc -l)

if (( $NBMINIONS > 0 ));
then
    echo "Starting with so many minion files: $NBMINIONS"
    if (( $NBMINIONS < $NBCORES ));
    then
        time parallel -j $NBCORES "minion -findallsols -split -timelimit $SHORT  {} -solsout {}.solutions > {}.stdout ; mv {} {}.done" ::: *.minion
    else
        time parallel -j $NBCORES "minion -findallsols -split -timelimit $LONGER {} -solsout {}.solutions > {}.stdout ; mv {} {}.done" ::: *.minion
    fi
    bash $0 $1 $2 $3
else
    echo "Finished. No more *.minion files here."
fi


