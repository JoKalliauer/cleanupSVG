#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export precisiondigits=2 #number of dicits for control points
export precisiondigitsN=4 #number of dicits
export meta=0 #0 removes metadata

./svg2validsvg.sh

./inkscapeBatchConverter.sh

./scour4compression.sh
#./svg2validsvg.sh #to remove flow text
./cleaner4compression.sh #only tested on Windows
./o4compression.sh #only tested on Windows
./cleaner4compression.sh #it is fast and makes a good readable file

./svg2validsvg.sh
