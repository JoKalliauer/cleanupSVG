#!/bin/bash

#Author: Johannes Kalliauer (JoKalliauer)
#created: 2017-10

#Last Edits:
#2017-10-29 13h14 new filename (by JoKalliauer)
#2017-11-01 delte style in text, Doctype minior changes, Remove stroke-width in text, not adding lineforwards, english explantations (by JoKalliauer)
#2017-11-20 dasharray due to stroke-dasharray="37.10, 37.10"
#2017-11-22 xml:space="preserve" in simple text removed
#2017-11-22 remove empty text;
#2017-11-22 Remove style in text with .
#2017-11-22 Remove stroke-width in text with .
#2017-11-27 remove style in text also if "[-\#\(\)]" is before
#2017-11-27 remove fill in text if x="..." y="..." is before
#2017-11-27 Remove stroke-width in text edited
#2017-11-27 Remove stroke-width in tspan
#2018-04-07 10h17 put no-filebreakc after definiton of $new, deleted the removement of spaces
#2018-04-28 not remove stroke-width in text
#2018-05-05 restructured

for file in *.svg;do

echo 
echo $file

## == Remove scecial characters in filename ==

#export i=$file #i will be overritan later, just for debugging
export new="${file//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_]/}"
if [ $new == '*.svg' ]; then #new has to be controlled because it might have "-" which confuses bash
 echo "no file, (or filename does not contain any default latin character (a-z) )"
 break
fi
export tmp=$(echo $new | cut -f1 -d".")

#If you want to overwrite the exisiting file, without any backup, delete the following three lines
export i=${tmp}M.svg
chmod u+r ./"${file}"
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml

echo $i start:


#simpifying text
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<text([[:lower:][:digit:]= #,-\,\"\-\.\(\)]*)>[[:space:]]*<tspan/<text\1><tspan/g" $i #remove spaces and linebreaks between text and tspan
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>[[:space:]]*<\/text>/<\/tspan><\/text>/g" $i #remove spaces and linebreaks between text and tspan
sed -ri "s/<text ([-[:lower:][:digit:].,\"= ]+) xml:space=\"preserve\">([-[:alnum:]\\\$\']+)<\/text>/<text \1>\2<\/text>/g" $i #remove xml:space="preserve" in text if unnecesarry
sed -ri 's/<text [-[:lower:][:digit:]= \"\:\.]+\/>//g' $i #remove empty text
sed -ri 's/<tspan [-[:lower:][:digit:]= \"\.\:\;\%]+\/>//g' $i #remove selfclosing tspan
sed -i "s/<tspan x=\"0\" y=\"0\">/<tspan>/g" $i #reduce options in tspan
sed -ri "s/<tspan>([]\[[:alnum:]\$\^\\\_\{\}= #\,\"\.\(\)\’\&\;\/Επιβάτες¸\°\'\"\@\:−-]*)<\/tspan>([ ]*)/\1/g" $i #remove unnecesarry <tspan>...</tspan> without attributes
sed -ri "s/<tspan[-[:lower:][:digit:]= \"\.]+> <\/tspan>([ ]*)//g" $i #remove useless,empty <tspan (...)> </tspan> without text

#<text transform="matrix\(([[:digit:]]+) 0 0 ([[:digit:]]+) 3455.7 1308.1\)">Central</text>
#<g transform="translate(3455.7 1308.1)"><text transform="scale(4.8 4.8)">Central</text></g>

#convert text-matrix to g-translate text-transform
sed -ri "s/<text([-[:alnum:]= #\,\"\.\(\)\;\'\:]*) transform=\"matrix\(([[:digit:]\.]+) 0 0 ([[:digit:]\.]+) ([[:digit:]\.]+) ([[:digit:]\.]+)\)\">([]\[[:alnum:]\$\^\\\_\{\}= #\,\"\.\(\)\’\&\;\/Επιβάτες¸\°\'\"\@\:−-]*)<\/text>([ ]*)/<g transform=\"translate\(\4 \5\)\"><text\1 transform=\"scale\(\2 \3\)\">\6<\/text><\/g>/g" $i #

# <switch transform="matrix(100 0 0 100 0 170)" font-size=".88" text-anchor="middle">
#convert switch-matrix to g-translate switch-translate
sed -ri "s/<switch([-[:alnum:]= #\,\"\.\(\)\;\'\:]*) transform=\"matrix\(([[:digit:]\.]+) 0 0 ([[:digit:]\.]+) ([[:digit:]\.]+) ([-[:digit:]\.]+)\)\"([-[:alnum:]= #\,\"\.\(\)\;\'\:]*)>/<switch transform=\"translate\(\4 \5\) scale\(\2 \3\)\"\1\6>/g" $i #

echo $i finish



done

