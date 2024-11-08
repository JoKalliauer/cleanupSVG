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
#2018-03-31 added Polyline; deleted spaces before tag, deleted ( id=".."|)

for file in *.svg;do
 
 export i=$file #i will be overritan later
 export fileN=$(echo $file | cut -f1 -d" ") #remove spaces if exsiting (and everything after)
 #export tmp=$(echo $fileN | cut -f1 -d".")
 export tmp=${fileN%.svg}
 
 
 #If you want to overwrite the exisiting file, without any backup, delete the following three lines
 export i=${tmp}E.svg
 cp ./"${file}" $i
 mv ./"${file}" ./${tmp}1.xml
 
 echo 
 echo $i start:
 
 #tspan to text
 #sed -ri  -e ':a' -e 'N' -e '$!ba' -e "s/<text([-[:alnum:]\,\.\"\=\:\ \#\(\)]*)( x=\"[-[:digit:]\.\ ]+\" y=\"[-[:digit:]\.\ ]+\"|   )([-[:alnum:]\,\.\"\=\:\ \#\(\)\%\']*)>[[:space:]]*<tspan([-[:alnum:]\,\.\"\=\:\ \#]*) x=\"([-[:digit:]\.\ ]+)\" y=\"([-[:digit:]\.\ ]+)\"([-[:alnum:]\,\.\"\=\:\ #]*)>([-–[:alnum:]\.\ \,\{\(\)]*)<\/tspan>/<text x=\"\5\" y=\"\6\"\1\3\4\7>\8/g" $i
 
 #remove objects:

 #sed -ri "s/ <rect ([-[:alnum:]=\.\" \#\(\)]+)\/>//g" $i #delete all Rectangles
  sed -i "s/\r/ /g" $i #remove carriage return (DOS,MAC)
 sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/\n[[:space:]]+/ /g" $i #reduce to one space
 sed -ri "s/<mask([[:alnum:] =\"]*) maskUnits=\"userSpaceOnUse\"( id=\"[[:alnum:]_]+\"|)>/<mask\1\2>/g" $i
 
 sed -ri 's/[[:space:]]*<(g|path|svg|flowRoot|defs|clipPath|radialGradient|linearGradient|filter|mask|pattern|use|defs|switch)/\n<\1 /g' $i
# sed -ri 's/[[:space:]]*<text /\n<text /g' $i #deactivated for PosibilityUngroup
#sed -ri 's/[[:space:]]*<tspan /\n<tspan /g' $i #ruins text
#  sed -ri 's/[[:space:]]*<rect /\n<rect /g' $i #deactivated for Flow2TextBySed


 sed -ri 's/<\/(g|flowRoot)>/<\/\1>\n/g' $i
 sed -ri 's/\n\n/\n/g' $i
 
 sed -ri 's/<image /<imageDEL /g' $i 
 
done

exit

i=delete.del

#works only after scour
DeleteOnDemand=<< END

#------------------------

#textPath
#sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/ <text>[[:space:]]*<textPath xlink:href=\"#[[:alpha:]]\">[[:space:]]*<tspan [-[:alnum:]´\.= \"]*\">[[:alnum:] ']*<\/tspan>[[:space:]]*<\/textPath>[[:space:]]*<\/text>//g" $i #delete al textPath

#------------------------



#delete text
# export i=obj.svg

sed -ri "s/ <text ([-[:alnum:]=\.\" \#\(\)\;\:\%\']+)>.*<\/text>//g" $i #delete all oneline-text
sed -ri "s/<tspan>([]\[[:alnum:]\$\^\\\_\{\}= #\,\"\.\(\)\’\&\;−-]*)<\/tspan>([ ]*)/\1/g" $i #remove unnecesarry <tspan>...</tspan> without attributes

sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/ <text ([-[:alnum:]=\.\" \#\(\)\;\:\%\']+)>([-[:alnum:][:space:] \'\’\“\”\/\(\)\!\,\:\#\.\=]*|<tspan ([-[:alnum:]=\.\" \#\(\)\;\:\%\,]+)>|<\/tspan>)*<\/text>//g" $i

#------------------------

#flowText
#sed -r "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\']*)><flowRegion( id=\"flowRegion[-[:digit:]]{4,6}\"|)><rect( id=\"rect[-[:digit:]]{4,6}\"|) x=\"([[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([[:lower:][:digit:]=\.\" \#]+)\/><\/flowRegion><flowPara([-[:alnum:]\.=\" \:\#]+)>.*<\/flowPara><\/flowRoot>//g" $i  #delete all flowtext

#------------------------
#Restliches

sed -ri "s/ <pattern [-[:alnum:]\"\.\=\ #\(\)\:]+\/>//g" $i

sed -ri "s/ <radialGradient [-[:alnum:]\"\.\=\ #\(\)\:]+\/>//g" $i

sed -ri "s/ <stop [-[:alnum:]\"\.\=\ #\(\)\:]+\/>//g" $i

sed -ri "s/ <linearGradient [-[:alnum:]\"\.\=\ #\(\)\:]+\/>//g" $i

END

TextImproveOnDemand=<< END
#tspan in tspan
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<tspan([-[:alnum:]\,\.\"\=\:\ \#]*) x=\"([-[:digit:]\.\ ]+)\" y=\"([-[:digit:]\.\ ]+)\"([-[:alnum:]\,\.\"\=\:\ \#]*)>[[:space:]]*<tspan([-[:alnum:]\,\.\"\=\:\ \#]*) x=\"([-[:digit:]\.\ ]+)\" y=\"([-[:digit:]\.\ ]+)\"([-[:alnum:]\,\.\"\=\:\ \#]*)>([-[:alnum:]\.\ \,\(\)]*)<\/tspan>/<tspan x=\"\6\" y=\"\7\"\1\4\5\8>\9/g" $i

#tspan to text
sed -ri  -e ':a' -e 'N' -e '$!ba' -e "s/<text([-aeflmnorst0-79\,\.\"\=\:\ \#\(\)]*)( x=\"[-[:digit:]\.\ ]+\" y=\"[-[:digit:]\.\ ]+\")/<text\2\1/g" $i # that x ist at the beginning (otherwise the next line would not work)
sed -ri  -e ':a' -e 'N' -e '$!ba' -e "s/<text( x=\"[-[:digit:]\.\ ]+\" y=\"[-[:digit:]\.\ ]+\"|)([-[:alnum:]\,\.\"\=\:\ \#\(\)\%\']*)>[[:space:]]*<tspan([-[:alnum:]\,\.\"\=\:\ \#]*) x=\"([-[:digit:]\.\ ]+)\" y=\"([-[:digit:]\.\ ]+)\"([-[:alnum:]\,\.\"\=\:\ #]*)>([-–[:alnum:]\.\ \,\{\(\)\♭\♯\/]*)<\/tspan>/<text x=\"\4\" y=\"\5\"\2\3\6>\7/g" $i #removes the first tspan of a text element


#tspan to text if text has no coordinates (alt,obsolet)
#sed -ri  -e ':a' -e 'N' -e '$!ba' -e "s/<text([-[:alnum:]\,\.\"\=\:\ \#\(\)]*)>[[:space:]]*<tspan([-[:alnum:]\,\.\"\=\:\ \#]*) x=\"([-[:digit:]\.\ ]+)\" y=\"([-[:digit:]\.\ ]+)\"([-[:alnum:]\,\.\"\=\:\ ]*)>([-–[:alnum:]\.\ \,]*)<\/tspan>/<text x=\"\3\" y=\"\4\"\1\2\5>\6/g" $i
#sed -ri  -e ':a' -e 'N' -e '$!ba' -e "s/<text([-[:alnum:]\,\.\"\=\:\ \#\(\)]*)( x=\"[-[:digit:]\.\ ]+\" y=\"[-[:digit:]\.\ ]+\"|)([-[:alnum:]\,\.\"\=\:\ \#\(\)\%\']*)>[[:space:]]*<tspan([-[:alnum:]\,\.\"\=\:\ \#]*) x=\"([-[:digit:]\.\ ]+)\" y=\"([-[:digit:]\.\ ]+)\"([-[:alnum:]\,\.\"\=\:\ #]*)>([-–[:alnum:]\.\ \,\{\(\)]*)<\/tspan>/<text x=\"\5\" y=\"\6\"\1\3\4\7>\8/g" $i

#tspan to text if tspan has no coordinates
sed -ri  -e ':a' -e 'N' -e '$!ba' -e "s/<text([-[:alnum:]\,\.\"\=\:\ \#\(\)]*) x=\"([-[:digit:]\.\ ]+)\" y=\"([-[:digit:]\.\ ]+)\"([-[:alnum:]\,\.\"\=\:\ \#\(\)\%\']*)>[[:space:]]*<tspan([-[:alnum:]\,\.\"\=\:\ \#\'\%]*)>([-–[:alnum:]\.\ \,\{\(\)]*)<\/tspan>/<text x=\"\2\" y=\"\3\"\1\4\5>\6/g" $i

#remove spaces bevor tspan
sed -ri -e ':a' -e 'N' -e '$!ba' -e  "s/[[:space:]]*<(\/|)tspan/<\1tspan/g" $i

END


