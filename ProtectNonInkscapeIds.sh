#!/bin/bash

#Author: Johannes Kalliauer (JoKalliauer)
#created: 2019-02

for file in *.svg;do

mv "$file" `echo ${file} | tr ' ' '_'` ;

## == Remove scecial characters in filename ==

export i=$file #i will be overritan later, just for debugging
export new="${file//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_\+]/}"
if [ $new == '*.svg' ]; then #new has to be controlled because it might have "-" which confuses bash
 echo "no file, (or filename does not contain any default latin character (a-z) )"
 break
fi
export tmp=${new%.svg}

#If you want to overwrite the exisiting file, without any backup, delete the following three lines
export i=${tmp}_.svg
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml

echo 
echo $i start:

 sed -ri "s/<svg id=\"svg[[:digit:]]+\"/<svg/g" $i
 sed -ri "s/<g id=\"g[[:digit:]]+\"/<g/g" $i
 sed -ri "s/<path id=\"path[[:digit:]]+\"/<path/g" $i
 sed -ri "s/<text id=\"text[[:digit:]]+\"/<text/g" $i
 sed -ri "s/<tspan id=\"tspan[[:digit:]]+\"/<tspan/g" $i
 sed -ri "s/<image id=\"image[[:digit:]]+\"/<image/g" $i


echo $i finish



done

