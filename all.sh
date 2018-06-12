#!/bin/bash

export sourceType="svg" #for convertin in InkscapeBatchConverter
export minfilesize=0 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

./svg2validsvg.sh

./InkscapeBatchConverter.sh
./scour4compression.sh
#./cleaner4compression.sh
./o4compression.sh
./validBycleaner.sh
./scour4compression.sh

./svg2validsvg.sh
