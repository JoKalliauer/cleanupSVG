#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export precisiondigits=2 #number of dicits for control points
export precisiondigitsN=4 #number of dicits
export meta=1 #1 keeps metadata

export prepost=1
./svg2validsvg.sh

./InkscapeBatchConverter.sh

./scour4compression.sh

if minfilesize==0; then
 export prepost=2 #Some Postprocessing needs linebreaks to work correctly
else
 export prepost=0
fi
./svg2validsvg.sh
