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

for file in *.svg;do

export i=$file #will be overritan later
export fileN=$(echo $file | cut -f1 -d" ") #remove spaces if exsiting (and everything after)
export tmp=$(echo $fileN | cut -f1 -d".")

#If you want to overwrite the exisiting file, without any backup, delete the following three lines
export i=${tmp}_.svg
cp ./"${file}" ./$i
mv ./"${file}" ./${tmp}bak1.xml

echo 
echo $i start:

#Remove W3C-invalid elements
sed -ri "s/ text-align=\"(end|center)\"//g"  ${i}
sed -i "s/ aria-label=\"[[:digit:]]\"//g" $i

#dissolve FlowtingText
sed -i "s/<flowRoot /<g /g" $i
sed -i "s/<\/flowRoot>/<\/g>/g" $i
sed -i "s/<flowRegion/<g/g" $i
sed -i "s/<\/flowRegion>/<\/g>/g" $i
sed -i "s/<flowPara\/>//g" $i
sed -ri "s/<flowPara>([[:alnum:]: \.,!\-\/]+)<\/flowPara>/<text>\1<\/text>/g" $i

#remove mostly useless elements
sed -ri "s/ letter-spacing=\"0([px]*)\"//g" $i
sed -ri "s/ word-spacing=\"0([px]*)\"//g" $i
sed -i "s/ stroke-width=\"1\"//g" $i
#sed -i "s/ fill-rule=\"evenodd\"//g" $i
sed -i "s/ stroke-linecap=\"square\"//g" $i 
sed -i "s/ stroke-miterlimit=\"10\"//g" $i #Bug in IncscapePDFImport 

#add DOCTYPE
sed -i -e 's/<svg /\n<svg /' $i

if [ -z ${meta+x} ]; then
 echo Metadata kept, but DOCTYPE added
 meta=2 
fi
 if [ $meta != 1 ]; then  
  if grep -qE "<svg ([[:lower:][:digit:]=\"\. -]*)version=\"1.0\"" $i; then
   sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\?>[[:space:]]*<svg /\?>\n<\!DOCTYPE svg PUBLIC \"-\/\/W3C\/\/DTD SVG 1.0\/\/EN\" \"http:\/\/www.w3.org\/TR\/2001\/REC-SVG-20010904\/DTD\/svg10.dtd\">\n<svg /' $i
  elif grep -qE "<svg ([[:lower:][:digit:]=\"\. -]*)version=\"1\"" $i; then
   sed -ri 's/<svg ([[:lower:][:digit:]=\"\. -]*)version=\"1\"/<svg \1version=\"1.0\"/' $i 
   sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\?>[[:space:]]*<svg /\?>\n<\!DOCTYPE svg PUBLIC \"-\/\/W3C\/\/DTD SVG 1.0\/\/EN\" \"http:\/\/www.w3.org\/TR\/2001\/REC-SVG-20010904\/DTD\/svg10.dtd\">\n<svg /' $i
  else
   sed -i -e ':a' -e 'N' -e '$!ba' -e "s/\?>[[:space:]]*<svg /\?>\n<\!DOCTYPE svg PUBLIC \'-\/\/W3C\/\/DTD SVG 1.1\/\/EN\' \'http:\/\/www.w3.org\/Graphics\/SVG\/1.1\/DTD\/svg11.dtd\'>\n<svg /" $i
   sed -ri 's/<svg ([[:lower:]=\"[:digit:] \.-]+) version="1.2" ([[:alnum:]=\" \.\/:]+)>/<svg \1 \2>/' $i
  fi
 fi


#Change spaces to , in stroke-dasharray (solves librsvg-Bug https://phabricator.wikimedia.org/T32033 )
sed -ri 's/stroke-dasharray=\"([[:digit:]\.,]*)([[:digit:]\.]+) ([[:digit:]\., ]+)\"/stroke-dasharray=\"\1\2,\3\"/g' $i
sed -ri 's/stroke-dasharray=\"([[:digit:]\., ]*)([[:digit:]\.]+) ([[:digit:]\.,]+)\"/stroke-dasharray=\"\1\2,\3\"/g' $i

#sed -ri 's/stroke-dasharray=\"([[:digit:]\.,]+) ([[:digit:]\., ]+)\"/stroke-dasharray=\"\1,\2\"/g' $i
#sed -ri 's/stroke-dasharray=\"([[:digit:]\., ]+) ([[:digit:]\.,]+)\"/stroke-dasharray=\"\1,\2\"/g' $i

#Change "'font name'" to 'font name'(solves librsvg-Bug)
sed -ri "s/font-family=\"'([[:alnum:] ]*)'\"/font-family=\'\1\'/g" $i

#Change to Wikis Fallbackfont https://commons.wikimedia.org/wiki/Help:SVG#fallback to be compatible with https://meta.wikimedia.org/wiki/SVG_fonts
sed -i 's/ font-family=\"Sans\"/ font-family=\"sans\"/g' $i #as automatic
sed -i 's/ font-family=\"Arial\"/ font-family=\"Liberation Sans\"/g' $i #as automatic
sed -i 's/ font-family=\"Bitstream Vera Serif\"/ font-family=\"DejaVu Serif\"/g' $i #as automatic
sed -i 's/ font-family=\"Bitstream Vera Sans\"/ font-family=\"DejaVu Sans\"/g' $i #as automatic
sed -i 's/ font-family=\"Bitstream Vera Sans Mono\"/ font-family=\"DejaVu Sans Mono\"/g' $i #as automatic
sed -i 's/ font-family=\"Times New Roman\"/ font-family=\"Liberation Serif\"/g' $i #as automatic
#sed -i 's/ fill=\"#002060\" font-family=\"Swis721 BlkCn BT\" font-size=\"/ fill=\"#002060\" font-family=\"Liberation Sans\" font-weight=\"bold\" font-size=\"/g' $i #looks similar
#sed -ri 's/ font-family=\"(Arial|Myriad Pro|ArialNarrow)\"/ font-family=\"Liberation Sans\"/g' $i #all Sans to Liberation
#sed -ri 's/ font-family=\"(Minion Pro|Times|Times New Roman|SVGTimes)\"/ font-family=\"Liberation Serif\"/g' $i #all Serif to Liberation

#simpifying text
#sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<tspan/\n<tspan/g" $i
#sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>/<\/tspan>\n/g" $i
sed -ri "s/<text ([-[:alnum:]\.=\'\"\ \-\#\(\)]+) style=\"[[:lower:];%[:digit:]\.:\-]+\"([[:lower:] =\:\"]*)>/<text \1>/g" $i #Remove style in text
sed -ri "s/<tspan ([[:alnum:]\.=\(\)\#\"\ \-]+) style=\"[[:lower:];%[:digit:]\.:\-]+\">/<tspan \1>/g" $i #Remove style in tspan
sed -ri "s/<text ([-[:alnum:]\.=\" \']+)\" stroke-width=\"([[:digit:]\.]+)\"([-[:lower:][:digit:]=\"\:\;\%]*)>/<text \1\"\3>/g" $i #Remove stroke-width in text
#sed -ri "s/<text ([[:alnum:]= \"\.\'-]+)\" stroke-width=\"([[:digit:]\.]+)\">/<text \1>/g" $i #remove stroke-width in text
sed -ri "s/<tspan ([-[:alnum:]\.=\" ]+)\" stroke-width=\"([[:digit:]\.px]+)\"([-[:lower:]=\"\ \/]*)>/<tspan \1\"\3>/g" $i #Remove stroke-width in tspan

sed -ri "s/<tspan x=\"([[:digit:]\.]+) ([[:digit:]\. ]+)\" y=\"([[:digit:]\. ]+)\"([[:alnum:]\.\"\#\ =-]*)>/<tspan x=\"\1\" y=\"\3\"\4>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
#sed -ri "s/<tspan x=\"([[:digit:]\. ]+)\" y=\"([[:digit:]\.]+) ([[:digit:]\. ]+)\">/<tspan x=\"\1\" y=\"\2\">/g" $i #remove multiple y-koordinates
sed -ri "s/<text([xy\ [:digit:]\"\.\=]*) fill=\"\#[[:xdigit:]]{3,6}\"/<text\1/g" $i #remove fill in text
sed -ri "s/<text ([[:alnum:]= \"\.-]+) stroke-width=\"([[:digit:]\.]+)\">/<text \1>/g" $i #remove stroke-width in text
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<text([[:lower:][:digit:]= #,-\,\"\-\.\(\)]*)>[[:space:]]*<tspan/<text\1><tspan/g" $i #remove spaces and linebreaks between text and tspan
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>[[:space:]]*<\/text>/<\/tspan><\/text>/g" $i #remove spaces and linebreaks between text and tspan
#sed -i -e ':a' -e 'N' -e '$!ba' -e "s/\n<tspan/<tspan/g" $i #remove lineforward before tspan
#sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<tspan/\n<tspan/g" $i #add lineforward before tspan
#sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>[[:space:]]+<tspan /<\/tspan> <tspan /g" $i #reduces multiple spaces to one space
sed -ri 's/<text x="([[:digit:]\.]+)" y="([[:digit:]\.]+)" xml:space="preserve">([[:alnum:]\\\$]+)<\/text>/<text x="\1" y="\2">\3<\/text>/g' $i #remove xml:space="preserve" in text if unnecesarry
sed -ri 's/<text [-[:lower:][:digit:]= \"\:\.]+\/>//g' $i #remove empty text
sed -ri 's/<tspan [-[:lower:][:digit:]= \"\.]+\/>//g' $i #remove empty tspan
sed -i "s/<tspan x=\"0\" y=\"0\">/<tspan>/g" $i #remove unnecesarry tspan
sed -ri "s/<tspan>([-[:alnum:]\$\^\\\_\{\}= #\,\"\.\(\)]*)<\/tspan>([ ]*)/\1/g" $i #remove unnecesarry <tspan>...</tspan> without attributes


#two lineforward to one lineforward
sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\n\n/\n/g' $i

#Remove CDATA by AdobeIllustrator
sed -ri "s/ xmlns:i=\"([amp38;\#\&\])+ns_ai;\"/ xmlns:i=\"http:\/\/ns.adobe.com\/AdobeIllustrator\/10.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\!\[CDATA\[([[:alnum:]=+\/\t\n[:space:]@:;\(\)\"\,\'\{\}\-])*\t\]\]>[[:space:]]*//g" $i #Remove CDATA
sed -ri "s/<i:pgfRef xlink:href=\"#a([[:lower:]_]*)\"\/>//" $i #Remove AI-Elemtents for CDATA
sed -i "s/<i:pgf id=\"a\"\/>//" $i #Remove AI-Elemtents for CDATA
sed -ri -e ':a' -e 'N' -e "s/<i:pgf( ){1,2}id=\"a([[:lower:]_])*\">[[:space:]]*<\/i:pgf>//" $i #Remove AI-Elemtents for CDATA
sed -i "s/ i:extraneous=\"self\"//" $i #Remove AI-Elemtents

#remove jpg im metadata
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<xapGImg:image>([[:alnum:][:space:]\/+])*={0,2}[[:space:]]*<\/xapGImg:image>//g" $i

#Repair https://phabricator.wikimedia.org/T68672 (solves librsvg-Bug)
sed -i "s/<style>/<style type=\"text\/css\">/" $i

#Repair WARNING in <mask> with id=ay: Mask element found with maskUnits set. It will not be rendered properly by Wikimedia's SVG renderer. See https://phabricator.wikimedia.org/T55899 for details
sed -ri "s/<mask id=\"([[:lower:]]+)\" ([[:lower:] =\"[:digit:]]+) maskUnits=\"userSpaceOnUse\">/<mask id=\"\1\" \2>/g" $i
#ArcMap-problems (made file valid, removes cbs= and gem=)
sed -ri "s/<path d=\"m([[:digit:]hlmvz \.-]+)\" ([[:alnum:]\"= \.\(\)\#-]*)\" cbs=\"[[:digit:]GM]*\" gem=\"[[:alpha:]0 \.\(\)-]*\"\/>/<path d=\"m\1\" \2\"\/>/g" $i

echo $i finish

done
