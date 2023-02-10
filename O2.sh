#!/bin/bash

#npm i svgo

for file in *.svg;do
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=$(echo $fileN | cut -f1 -d".")
export i=${tmp}O.svg

echo optizer ${file} to $i begin

svgo -i "${file}" -o $i -p 5 --pretty --indent=1 --multipass  



echo mv ./${file} ./${tmp}5.xml
mv "./${file}" ./${tmp}5.xml

echo svgo $i finish

done

