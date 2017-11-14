#!/bin/bash

export minfilesize=0 #1..min file size
export precisiondigits=2 #number of dicits for control points
export precisiondigitsN=4 #number of dicits
export meta=0 #0 removes metadata

./svg2validsvg.sh

./InkscapeBatchConverter.sh

./scour4compression.sh

./svg2validsvg.sh
