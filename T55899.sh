#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

./einzeilTags.sh
./svg2validsvg.sh
./InkscapeBatchConverter.sh
./einzeilTags.sh

./cleaner4compression.sh
#./o4compression.sh #https://github.com/svg/svgo/issues/1001

##./einzeilTags.sh
##./PosibleUngroup.sh
##./UngroupByInkscape.sh
##./Flow2TextByInkscape.sh
##./SimplifyByInkscape.sh

#./scour4compression.sh #https://github.com/scour-project/scour/issues/202
./CleanerFull.sh
##./cleaner4compression.sh
##./o4compression.sh
##./OptimizerFull.sh
#./o4compression.sh #https://github.com/svg/svgo/issues/1001

./fontReplace.sh
./validBycleaner.sh
./svg2validsvg.sh
