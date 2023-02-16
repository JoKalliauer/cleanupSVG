#!/bin/bash


# better results can be achived using https://tinyjpg.com/

jpegoptim *.jpg
jpegoptim *.jpeg
jpegoptim *.JPG

for file in *.jpg
do

echo #Add a empty line to split the output

#pingo $file
#optipng $file
pingo -sa  $file

#pingo $file

done

for file in *.jpeg
do

echo #Add a empty line to split the output

#pingo $file
#optipng $file
pingo -sa  $file

#pingo $file

done

for file in *.JPG
do

echo #Add a empty line to split the output

#pingo $file
#optipng $file
pingo -sa $file

#pingo $file

done

wait
