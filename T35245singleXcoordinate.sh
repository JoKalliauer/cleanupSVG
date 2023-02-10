#!/bin/bash

for file in *.svg;do

## == Remove special characters in filename ==

export new="${file//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_\+]/}"
if [ $new == '*.svg' ]; then #new has to be controlled because it might have "-" which confuses bash
 echo "no file, (or filename does not contain any default Latin character (a-z) )"
 break
fi
export tmp=${new%.svg}

#If you want to overwrite the existing file, without any backup, delete the following three lines
export i=${tmp}T.svg
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml

echo 
echo $i start:

sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =\(\)]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =\,:\\]*)>/<tspan x=\"\2\"\1\5>/g" $i # remove multipe x-koordinates in text (solves librsvg-Bug)
sed -ri "s/<text([-[:alnum:]\.\"\#\ =\(\)]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =\,:\\\(\)]*)>/<text x=\"\2\"\1\5>/g" $i # remove multipe x-koordinates in text (solves librsvg-Bug)

 
 sed -ri "s/ unicode-bidi=\"embed\"//g" $i
 

echo $i finish



done
