#!/bin/bash

export sourceType="svg" #for convertin in InkscapeBatchConverter
export minfilesize=0 #1..min file size (1...no line breaks)
export meta=1 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

./pre.sh

#./Vacuumdefs.sh # this might add ids
./minscour4compression.sh
./mincleaner4compression.sh #deactivate if CSS
./mino4compression.sh
./validBySed.sh

./fontReplace.sh
./svg2validsvg.sh
./styleNomincleaner4compression.sh

export meta=0
./minscour4compression.sh
