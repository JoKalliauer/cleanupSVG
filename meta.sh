#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export meta=1 #1 keeps metadata
export outputType="svg" #just to not get asked by Inkscape

./svg2validsvg.sh

./InkscapeBatchConverter.sh

./scour4compression.sh
#./svg2validsvg.sh #to remove flow text
./cleaner4compression.sh #only tested on Windows
./o4compression.sh #only tested on Windows
./scour4compression.sh #handles metadata without problems

./svg2validsvg.sh
