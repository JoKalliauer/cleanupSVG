#!/bin/bash

#Author: Johannes Kalliauer (JoKalliauer)

./einzeilTags.sh

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

#remove empty flow Text in svg (everything else will be done by https://github.com/JoKalliauer/cleanupSVG/blob/master/Flow2TextByInkscape.sh , newest version see svg2validsvg.sh)
sed -ri 's/<flowPara([-[:alnum:]\" \.\:\%\=]*)\/>//g;s/<flowRoot\/>//g' $i
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" #;\.%]*)(\/|>[[:space:]]*<(path|rect)([-[:alnum:]\"= \.:;# ]*)\/>[[:space:]]*<\/flowRegion)>[[:space:]]*(<flowDiv\/>|)[[:space:]]*<\/flowRoot>//g" $i #delete empty flowRoot
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" #;\.%]*)>[[:space:]]*(<path[-[:alnum:]\.=\"\ \#]*\/>|<rect([-[:alnum:]\"= \.:;]*) x=\"([[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([[:lower:][:digit:]=\.\" \#:;]+)\/>)[[:space:]]*<\/flowRegion>[[:space:]]*(|<flowPara([-[:alnum:]\.=\" \:\#;% ]*)\/>|<flowPara([-[:alnum:]\"= \.\:\#;%]*)>([[:space:] ]*)<\/flowPara>)[[:space:]]*<\/flowRoot>//g" $i ##delete flowRoot only containing spaces


 #   <flowRoot transform="matrix(.26458 0 0 .26458 -19.267 -12.985)" fill="#000000" font-family="DejaVu Sans,sans-serif" font-size="40px" letter-spacing="-6.25px" stroke-width="1px" style="line-height:79.19999957%" xml:space="preserve"><flowRegion style="line-height:79.19999957%"><rect x="3713.9" y="2203.9" width="241.2" height="126.32"/></flowRegion><flowPara fill="#fafafa" font-size="74.667px" text-anchor="middle" style="line-height:79.19999957%">Call-</flowPara><flowPara fill="#fafafa" font-size="74.667px" text-anchor="middle" style="line-height:79.19999957%">isto</flowPara></flowRoot>
sed -ri "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" #;\.%\',]*)>[[:space:]]*<rect([-[:lower:][:digit:]\"= \.:;]*) x=\"([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([-[:alnum:]=\.\" \#:;\',]*)\/>[[:space:]]*<\/flowRegion>[[:space:]]*<flowPara([-[:alnum:]\.=\" \:\#;\%]*)>([-−[:alnum:] \{\}\(\)\+\ \ \.\?\']+)<\/flowPara>[[:space:]]*<\/flowRoot>/<text x=\"\4\" y=\"\5\"\1><tspan x=\"\4\" y=\"\5\"\7>\8<\/tspan><\/text>/g" $i
 

 

echo $i finish



done

