#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export precisiondigits=3 #number of dicits for control points
export precisiondigitsN=5 #number of dicits
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape

./svg2validsvg.sh

./inkscapeBatchConverter.sh

./scour4compression.sh
#./svg2validsvg.sh #to remove flow text
./cleaner4compression.sh #only tested on Windows
./o4compression.sh #only tested on Windows
./scour4compression.sh #it is fast and makes a good readable file

./svg2validsvg.sh
