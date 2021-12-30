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
export i=${tmp}t.svg
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml

echo 
echo $i start:



#simpifying text
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<text([[:lower:][:digit:]= #-\,\"\-\.\(\)]*)>[[:space:]]*<tspan/<text\1><tspan/g" $i #remove spaces and linebreaks between text and tspan
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>[[:space:]]*<\/text>/<\/tspan><\/text>/g" $i #remove spaces and linebreaks between text and tspan
sed -ri "s/<text([-[:lower:][:digit:].,\"= ]+) xml:space=\"preserve\">([-[:alnum:]\\\$\']+)<\/text>/<text\1>\2<\/text>/g" $i #remove xml:space="preserve" in text if unnecesarry
sed -ri 's/<text [-[:lower:][:digit:] =\"\:\.]+\/>//g' $i #remove empty text
sed -ri 's/<tspan [-[:lower:][:digit:] =\"\.\:\;\%]+\/>//g' $i #remove selfclosing tspan
sed -i "s/<tspan x=\"0\" y=\"0\">/<tspan>/g" $i #reduce options in tspan
sed -ri "s/<tspan>([]\[[:alnum:]\$\^\\\_\{\}= #\,\"\.\(\)\’\&\;\/Επιβάτες¸\°\'\"\@\:−-]*)<\/tspan>([ ]*)/\1/g" $i #remove unnecesarry <tspan>...</tspan> without attributes
sed -ri "s/<tspan[-[:lower:][:digit:] =\"\.]+> <\/tspan>([ ]*)//g" $i #remove useless,empty <tspan (...)> </tspan> without text


#sed -ri "s/<text transform=\"matrix\(([[:digit:]\.]+) 0 0 ([[:digit:]\.]+) ([[:digit:]\.]+) ([[:digit:]\.]+)\)\">([]\[[:alnum:]\$\^\\\_\{\}= #\,\"\.\(\)\’\&\;\/Επιβάτες¸\°\'\"\@\:−-]*)<\/text>([ ]*)/<g transform=\"translate\(\3 \4\)\"><text transform=\"scale\(\1 \2\)\">\5<\/text><\/g>/g" $i #remove unnecesarry <tspan>...</tspan> without attributes

sed -ri "s/<g([-[:alnum:]\(\)\. ,;:=\"#]*) font-size=\"([[:digit:]\.]*)\"([-[:alnum:]\(\)\. ,;:=\"#]*)>((<text|[[:alnum:]\$\^\\\_\{\}= #\,\"\.\(\)\’\&\;\/\'\"\@\:−-]*|>|<\/text>|<tspan|<\/tspan>)*)<text/<g\1 font-size=\"\2\"\3>\4<text font-size=\"\2\"/g" $i


#  if grep -qE "<g([-[:alnum:]\(\)\. ,;:=\"#]*) font-size=" $i; then
#   sed -i 's/<text/<text /g' $i
#  fi

#tspan in tspan
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<tspan([-[:alnum:]\,\.\"\=\:\ #]*) x=\"([-[:digit:]\.\ ]+)\" y=\"([-[:digit:]\.\ ]+)\"([-[:alnum:]\,\.\"\=\:\ #]*)>[[:space:]]*<tspan([-[:alnum:]\,\.\"\=\:\ #]*) x=\"([-[:digit:]\.\ ]+)\" y=\"([-[:digit:]\.\ ]+)\"([-[:alnum:]\,\.\"\=\:\ #\(\)]*)>([- [:alnum:]\.\,\(\)]*)<\/tspan>/<tspan x=\"\6\" y=\"\7\"\1\4\5\8>\9/g" $i
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<tspan([-[:alnum:]\,\.\"\=\:\ #]*) x=\"([-[:digit:]\.\ ]+)\" y=\"([-[:digit:]\.\ ]+)\"([-[:alnum:]\,\.\"\=\:\ #]*)>[[:space:]]*<tspan([-[:alnum:]\,\.\"\=\:\ #\(\)]*)>([- [:alnum:]\.\,\(\)\ä\ü\…]*)<\/tspan>/<tspan x=\"\2\" y=\"\3\"\1\4\5>\6/g" $i
#tspan to text

#tspan to text
sed -ri  -e ':a' -e 'N' -e '$!ba' -e "s/<text([-[:alnum:]\,\.\"\=\:\ #\(\)]*)( x=\"[-[:digit:]\.\ ]+\" y=\"[-[:digit:]\.\ ]+\")/<text\2\1/g" $i # that x ist at the beginning (otherwise the next line would not work)
# <text x="116.28" y="109.74" stroke-width=".75"><tspan x="116.28" y="109.74">CH</tspan></text>
# <text x="-.36" y="42.46" id="g" font-size="16.29" stroke-linecap="round" stroke-linejoin="round" stroke-width=".75"><tspan x="-.36" y="42.46">H C</tspan></text>
#<text x="739.9" y="1932.4"><tspan font-style="italic" font-weight="400" x="745" y="1932.4">t<tspan baseline-shift="sub" font-size="32.104">0</tspan> +h</tspan></text>
sed -ri  -e ':a' -e 'N' -e '$!ba' -e "s/<text( x=\"[-[:digit:]\.\ ]+\" y=\"[-[:digit:]\.\ ]+\"|)([-[:alnum:]\,\.\"\=\:\ \#\(\)\%\']*)>[[:space:]]*<tspan([-[:alnum:]\,\.\"\=\:\ \#\'\(\)]*) x=\"([-[:digit:]\.\ ]+)\" y=\"([-[:digit:]\.\ ]+)\"([-[:alnum:]\,\.\"\=\:\ #]*)>([-–[:alnum:]\.\ \,\'\♭\♯\/%≈¹²³⁴⁶⁷⁸⁹•…\{\(\)\+\ä\ü\á\…°_$=])*<\/tspan>/<text x=\"\4\" y=\"\5\"\2\3\6>\7/g" $i #removes the first tspan of a text element



#put every text in its own group
sed -ri "s/(<g[-[:alnum:]\(\)\. ,;:=\"#]*>)[[:space:]]*((<text[-[:alnum:]= #\,\"\.\(\)\;\'\"\:]*>|<tspan[- [:alnum:]=\.\"]*>|<\/tspan>|[-[:alnum:]\,\.\(\) =]*)*)<\/text>/\1\2<\/text><\/g>\1/g" $i
sed -ri "s/(<g[-[:alnum:]\(\)\. ,;:=\"#]*>)[[:space:]]*((<text[-[:alnum:]= #\,\"\.\(\)\;\'\"\:]*>|<tspan[- [:alnum:]=\.\"]*>|<\/tspan>|[-[:alnum:]\,\.\(\) =]*)*)<\/text>/\1\2<\/text><\/g>\1/g" $i
sed -ri "s/(<g[-[:alnum:]\(\)\. ,;:=\"#]*>)[[:space:]]*((<text[-[:alnum:]= #\,\"\.\(\)\;\'\"\:]*>|<tspan[- [:alnum:]=\.\"]*>|<\/tspan>|[-[:alnum:]\,\.\(\) =]*)*)<\/text>/\1\2<\/text><\/g>\1/g" $i
sed -ri "s/(<g[-[:alnum:]\(\)\. ,;:=\"#]*>)[[:space:]]*<text([-[:alnum:]= #\,\"\.\(\)\;\'\"\:]*)>([-[:alnum:]\,\.\(\) =]*)<\/text>/\1<text\2>\3<\/text><\/g>\1/g" $i
sed -ri "s/(<g[-[:alnum:]\(\)\. ,;:=\"#]*>)[[:space:]]*<text([-[:alnum:]= #\,\"\.\(\)\;\'\"\:]*)>([-[:alnum:]\,\.\(\) =]*)<\/text>/\1<text\2>\3<\/text><\/g>\1/g" $i

#sed -ri "s/<g([-[:alnum:]\(\)\. ,;:=\"#]*)( font-size=\"[-[:digit:]\.\ ]+\")([-[:alnum:]\(\)\. ,;:=\"#]*)><text([-[:alnum:]= #\,\"\.\(\)\;\'\"\:]*)>([-[:alnum:]\,\.\(\) =]*)<\/text><\/g>/<g\1\2\3><text\2\4>\5<\/text><\/g>/g" $i


#remove two font-size
sed -ri "s/<text([-[:alnum:]\,\.\"\=\:\ #\(\)\']*)( font-size=\"[-[:digit:]\.\ ]+\")([-[:alnum:]\,\.\"\=\:\ #\(\)\']*) font-size=\"([-[:digit:]\.\ ]+)\"/<text\1\3 font-size=\"\4\"/g" $i
sed -ri "s/<text([-[:alnum:]\,\.\"\=\:\ #\(\)\']*)( font-size=\"[-[:digit:]\.\ ]+\")([-[:alnum:]\,\.\"\=\:\ #\(\)\']*) font-size=\"([-[:digit:]\.\ ]+)\"/<text\1\3 font-size=\"\4\"/g" $i

#remove double elements
sed -ri "s/text-align=\"center\" text-anchor=\"middle\" text-align=\"center\" text-anchor=\"middle\"/text-align=\"center\" text-anchor=\"middle\"/g" $i

echo $i finish



done

