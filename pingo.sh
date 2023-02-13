#!/bin/bash

for file in *.png
do

echo #Add a empty line to split the output

pingo -s9 $file
optipng $file
oxipng -o 6 -Z "$file"

done

wait
