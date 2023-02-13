#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

#./einzeilTags.sh
./pre.sh
#./InkscapeBatchConverter.sh
#./Vacuumdefs.sh
./scour4compression.sh
./between.sh
./cleaner4compression.sh
./o4compression.sh

./Rounding.sh
#./ResizeByInkscape.sh
#./einzeilTags.sh
#./PosibleUngroup.sh
#./UngroupByInkscape.sh
./Flow2TextByInkscape.sh
##./FFlow2TextBySed.sh
##./Text2Path.sh
#./SimplifyByInkscape.sh

# ./viewBox.sh


./validByScour.sh
./ScourFull.sh
#./scour4compression.sh
./CleanerFull.sh
#./cleaner4compression.sh
#./o4compression.sh
./RasterOptimizer.sh
#./OptimizerFull.sh

./validByo4compression.sh
./validBycleaner.sh
./validByscour.sh
./validBySed.sh
./fontReplace.sh
./svg2validsvg.sh
./post.sh
