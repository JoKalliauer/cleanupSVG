#!/bin/bash

for file in *.png
do

echo #Add a empty line to split the output

#pingo $file
optipng $file
pingo  $file

#pingo $file

done

wait
