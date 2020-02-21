#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging


./pre.sh

#./Vacuumdefs.sh

./RasterOptimizer.sh
./CleanerFull.sh
./ScourFull.sh

#./validByo4compression.sh
#./validBycleaner.sh
#./validByscour.sh
./validBySed.sh
./fontReplace.sh
./svg2validsvg.sh
./post.sh
