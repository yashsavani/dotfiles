#!/bin/bash
REPO=$(git rev-parse --show-toplevel)
echo Starting sync daemon for $REPO
if [[ $1 == "all" ]];
then
    echo "Syncing on localgpu and locus"
    fswatch -e -o $REPO | xargs -n1 -I{} bash -c "rsync -avz $REPO ysavani@localgpu:~; rsync -avz $REPO ysavani@locus:~"
elif [[ $1 == "locus" ]];
then
    echo "Syncing locus only"
    fswatch -e -o $REPO | xargs -n1 -I{} bash -c "rsync -avz $REPO ysavani@locus:~"
else
    echo "Syncing localgpu only"
    fswatch -e -o $REPO | xargs -n1 -I{} bash -c "rsync -avz $REPO ysavani@localgpu:~"
fi

