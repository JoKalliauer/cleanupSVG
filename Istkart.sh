#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

# how to correct Files by Thomas Steifer https://commons.wikimedia.org/w/index.php?title=Special:ListFiles&offset=20061221023005&limit=500&user=Steifer&ilshowall=1

./svg2validsvg.sh
./InkscapeBatchConverter.sh
./scour4compression.sh
./cleaner4compression.sh
./o4compression.sh
./ResizeByInkscape.sh
./ScourFull.sh
./OptimizerFull.sh
./CleanerFull.sh
./cleaner4compression.sh
./scour4compression.sh
./svg2validsvg.sh
