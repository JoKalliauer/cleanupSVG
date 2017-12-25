#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export precisiondigits=2 #number of dicits for control points
export precisiondigitsN=4 #number of dicits
export meta=1 #1 keeps metadata

./svg2validsvg.sh

./InkscapeBatchConverter.sh

./scour4compression.sh
./svg2validsvg.sh #to remove flow text
./cleaner4compression.sh #only tested on Windows
./o4compression.sh #only tested on Windows
./scour4compression.sh #handles metadata without problems

./svg2validsvg.sh
