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
export i=${tmp}F.svg
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml

echo 
echo $i start:

#remove empty flow Text in svg (everything else will be done by https://github.com/JoKalliauer/cleanupSVG/blob/master/Flow2TextByInkscape.sh )
sed -ri 's/<flowPara([-[:alnum:]\" \.\:\%\=]*)\/>//g;s/<flowRoot\/>//g' $i
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion(\/|>[[:space:]]*<(path|rect) [-[:digit:]deghimtvwxyz\. \"\=]*\/>[[:space:]]*<\/flowRegion)>[[:space:]]*(<flowDiv\/>|)[[:space:]]*<\/flowRoot>//g" $i #delete empty flowRoot
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" ]*)>[[:space:]]*(<path[-[:alnum:]\.=\"\ \#]*\/>|<rect( id=\"rect[-[:digit:]]{2,7}\"|) x=\"([[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([[:lower:][:digit:]=\.\" \#]+)\/>)[[:space:]]*<\/flowRegion>[[:space:]]*(<flowPara([-[:alnum:]\" \.\%])\/>|<flowPara([-[:alnum:]\" \.\:\%\=]*)>([[:space:] ]*)<\/flowPara>)[[:space:]]*<\/flowRoot>//g" $i ##delete flowRoot only containing spaces


#<flowRoot id="flowRoot14827" transform="matrix(.996351 .0853476 -.0853476 .996351 255.594 1000.17)" style="display:inline;fill:#a41dec;font-family:Verdana;font-size:16px;letter-spacing:0px;line-height:1.25;stroke-opacity:.976636;word-spacing:0px" xml:space="preserve"><flowRegion id="flowRegion14829" style="fill:#a41dec;stroke-opacity:.976636"><rect id="rect14831" x="230.31" y="446.53" width="319.06" height="84.3491" style="fill:#a41dec"/></flowRegion><flowPara id="flowPara14833" style="fill:#a41dec;font-family:Verdana;font-size:26.6667px;stroke-opacity:.976636;text-align:end;text-anchor:end">?</flowPara></flowRoot>
sed -ri "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" #;\.]*)>[[:space:]]*<rect([-[:lower:][:digit:]\"= \.]*) x=\"([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([-[:lower:][:digit:]=\.\" \#:]*)\/>[[:space:]]*<\/flowRegion>[[:space:]]*<flowPara([-[:alnum:]\.=\" \:\#;\%]*)>([-−[:alnum:] \{\}\(\)\+\ \ \.\?]+)<\/flowPara>[[:space:]]*<\/flowRoot>/<text x=\"\4\" y=\"\5\"\1><tspan x=\"\4\" y=\"\5\"\7>\8<\/tspan><\/text>/g" $i

echo $i finish



done
