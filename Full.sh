#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

./all.sh
./ScourFull.sh
./ScourFull.sh
./scour4compression.sh
./CleanerFull.sh
./CleanerFull.sh
./cleaner4compression.sh
./o4compression.sh
./OptimizerFull.sh
./OptimizerFull.sh
./OptimizerFull.sh
./o4compression.sh
./all.sh