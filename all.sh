#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export precisiondigits=3 #number of dicits for control points
export precisiondigitsN=5 #number of dicits
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

./svg2validsvg.sh

./InkscapeBatchConverter.sh

./scour4compression.sh
#./svg2validsvg.sh #to remove flow text
./cleaner4compression.sh #only tested on Windows
./o4compression.sh #only tested on Windows
./scour4compression.sh #handles metadata without problems

./svg2validsvg.sh
