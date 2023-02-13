#!/bin/bash

export sourceType="svg" #for convertin in InkscapeBatchConverter
export minfilesize=0 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

#./Vacuumdefs.sh
./between.sh
./validBycleaner.sh
./validByo4compression.sh #after svgcleaner https://github.com/svg/svgo/issues/1146
./validByscour.sh
./validBySed.sh
./svg2validsvg.sh
./post.sh