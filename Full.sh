#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

#./einzeilTags.sh
./svg2validsvg.sh
./InkscapeBatchConverter.sh
./Vacuumdefs.sh
./scour4compression.sh
./cleaner4compression.sh
./o4compression.sh

#./ResizeByInkscape.sh
#./einzeilTags.sh
#./PosibleUngroup.sh
#./UngroupByInkscape.sh
#./Flow2TextByInkscape.sh
#./SimplifyByInkscape.sh

./ScourFull.sh
./ScourFull.sh
#./scour4compression.sh
./CleanerFull.sh
#./cleaner4compression.sh
#./o4compression.sh
./OptimizerFull.sh
./o4compression.sh

./validBycleaner.sh
./scour4compression.sh
./fontReplace.sh
./svg2validsvg.sh
