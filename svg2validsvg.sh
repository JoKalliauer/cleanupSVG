#!/bin/bash

#Author: Johannes Kalliauer (JoKalliauer)
#created: 2017-10

#Last Edits:
#2017-10-29 13h14 new filename (by JoKalliauer)

for file in *.svg;do

export i=$file #will be overritan later
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=$(echo $fileN | cut -f1 -d".")


export i=${tmp}_.svg
cp ./${file} ./$i
mv ./${file} ./${tmp}bak1.xml

echo 
echo $i start:


#Remove W3C-invalid elements
sed -ri "s/ text-align=\"(end|center)\"//g"  ${i}
sed -i "s/ aria-label=\"[[:digit:]]\"//g" $i

#Fliestext aufloesen
sed -i "s/<flowRoot /<g /g" $i
sed -i "s/<\/flowRoot>/<\/g>/g" $i
sed -i "s/<flowRegion/<g/g" $i
sed -i "s/<\/flowRegion>/<\/g>/g" $i
sed -i "s/<flowPara\/>//g" $i
sed -ri "s/<flowPara>([[:alnum:]: \.,!\-\/]+)<\/flowPara>/<text>\1<\/text>/g" $i


#remove useless elements
sed -i "s/ letter-spacing=\"0\"//g" $i
sed -i "s/ word-spacing=\"0\"//g" $i
sed -i "s/ stroke-width=\"1\"//g" $i
sed -i "s/ fill-rule=\"evenodd\"//g" $i
sed -i "s/ stroke-linecap=\"square\"//g" $i 

#add DOCTYPE
sed -i -e 's/<svg /\n<svg /' $i

if [ -z ${meta+x} ]; then
 echo Metadata kept, but DOCTYPE added
 meta=2 
fi

 if [ $meta != 1 ]; then  
  if grep -qE "<svg ([[:lower:][:digit:]=\"\. -]*)version=\"1.0\"" $i; then
   sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\?>[[:space:]]*<svg /\?>\n<\!DOCTYPE svg PUBLIC \"-\/\/W3C\/\/DTD SVG 1.0\/\/EN\" \"http:\/\/www.w3.org\/TR\/2001\/REC-SVG-20010904\/DTD\/svg10.dtd\">\n<svg /' $i
  else
   sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\?>[[:space:]]*<svg /\?>\n<\!DOCTYPE svg PUBLIC \"-\/\/W3C\/\/DTD SVG 1.1\/\/EN\" \"http:\/\/www.w3.org\/Graphics\/SVG\/1.1\/DTD\/svg11.dtd\">\n<svg /' $i
   sed -ri 's/<svg ([[:lower:]=\"[:digit:] \.-]+) version="1.2" ([[:alnum:]=\" \.\/:]+)>/<svg \1 \2>/' $i
  fi
 fi




#Change spaces to ,  (WikiRender-Bug)
sed -ri 's/stroke-dasharray=\"([[:digit:]\.]+) ([[:digit:]\.]+)\"/stroke-dasharray=\"\1,\2\"/g' $i
#Change "'font name'" to 'font name'
sed -ri "s/font-family=\"'([[:alpha:] ])'\"/font-family=\'\1\'/g" $i

#Change to Wikis Fallbackfont
sed -i 's/ font-family=\"Sans\"/ font-family=\"sans\"/g' $i
sed -i 's/ font-family=\"Arial\"/ font-family=\"Liberation Sans\"/g' $i #as automatic
sed -i 's/ font-family=\"Bitstream Vera Serif\"/ DejaVu Serif\"/g' $i #as automatic
sed -i 's/ font-family=\"Bitstream Vera Sans\"/ font-family=\"DejaVu Sans\"/g' $i #as automatic
sed -i 's/ font-family=\"Bitstream Vera Sans Mono\"/ font-family=\"DejaVu Sans Mono\"/g' $i #as automatic
#sed -ri 's/ font-family=\"(Arial|Myriad Pro)\"/ font-family=\"Liberation Sans\"/g' $i #all Sans to Liberation
#sed -ri 's/ font-family=\"(Minion Pro|Times|Times New Roman|SVGTimes)\"/ font-family=\"Liberation Serif\"/g' $i #all Serif to Liberation

#simpifying text
#sed -i -e ':a' -e 'N' -e '$!ba' -e "s/\n<tspan/<tspan/g" $i
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<tspan/\n<tspan/g" $i
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>/<\/tspan>\n/g" $i
#sed -ri "s/ style=\"[[:lower:];=%[:digit:]:\-]+\"//g"  $i
sed -ri "s/<text ([[:digit:]\.[:lower:]=\"\ \-]+) style=\"[[:lower:];%[:digit:]:\-]+\">/<text \1>/g" $i #Remove style in text
sed -ri "s/<tspan ([[:alnum:]\.=\(\)\#\"\ \-]+) style=\"[[:lower:];%[:digit:]\.:\-]+\">/<tspan \1>/g" $i #Remove style in tspan

#sed -i "s/ fill=\"#000\"//g" $i
sed -ri "s/<tspan>([[:alnum:]= #,-\,\"\-\.\(\)]*)<\/tspan>/\1/g" $i #remove unnecesarry <tspan>...</tspan> without attributes
sed -ri "s/<tspan x=\"([[:digit:]\.]+) ([[:digit:]\. ]+)\" y=\"([[:digit:]\. ]+)\"([[:alnum:]\.\"\#\ =-]*)>/<tspan x=\"\1\" y=\"\3\"\4>/g" $i # remove multipe x-koordinates in tspan
#sed -ri "s/<tspan x=\"([[:digit:]\. ]+)\" y=\"([[:digit:]\.]+) ([[:digit:]\. ]+)\">/<tspan x=\"\1\" y=\"\2\">/g" $i
sed -ri "s/<text fill=\"\#[[:xdigit:]]{6}\" /<text /g" $i #remove fill in text
sed -ri "s/<text ([[:alnum:]= \"\.-]+) stroke-width=\"([[:digit:]\.]+)\">/<text \1>/g" $i #remove stroke-width in text
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<text([[:lower:][:digit:]= #,-\,\"\-\.\(\)]*)>[[:space:]]*<tspan/<text\1><tspan/g" $i #remove spaces and linebreaks
#sed -r "s/<text([[:lower:][:digit:]= \"\-]*)>[[:space:]]*<tspan([[:alnum:]= \.\"\-]*)>(.*)<\/tspan><\/text>/<text\1><tspan\2>\3<\/tspan><\/text>/g" $i
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>[[:space:]]*<\/text>/<\/tspan><\/text>/g" $i #remove spaces
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/\n<tspan/<tspan/g" $i
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/\n<tspan/<tspan/g" $i
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>[[:space:]]+<tspan /<\/tspan> <tspan /g" $i

#Doppelte Zeilenumbruche(zwei Lineforward) zu einefachen Zeilenumbruch (einfachen Lineforward)
sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\n\n/\n/g' $i

#Remove CDATA
sed -ri "s/ xmlns:i=\"([amp38;\#\&\])+ns_ai;\"/ xmlns:i=\"http:\/\/ns.adobe.com\/AdobeIllustrator\/10.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\!\[CDATA\[([[:alnum:]=+\/\t\n[:space:]@:;\(\)\"\,\'\{\}\-])*\t\]\]>[[:space:]]*//g" $i #Remove CDATA
#sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\!\[CDATA\[([[:alnum:]=+\/\t\n[:space:]])*\t\]\]>[[:space:]]*<\/i:pgf>/<\/i:pgf>/g" $i #Remove CDATA
#sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/([[:alnum:]=+\/\t\n])+[[:space:]]\t\]\]>[[:space:]]*<\/i:pgf>/\t\]\]><\/i:pgf>/g" $i #Remove CDATA
sed -ri "s/<i:pgfRef xlink:href=\"#a([[:lower:]_]*)\"\/>//" $i #Remove AI-Elemtents for CDATA
sed -i "s/<i:pgf id=\"a\"\/>//" $i #Remove AI-Elemtents for CDATA
sed -ri -e ':a' -e 'N' -e "s/<i:pgf( ){1,2}id=\"a([[:lower:]_])*\">[[:space:]]*<\/i:pgf>//" $i #Remove AI-Elemtents for CDATA
sed -i "s/ i:extraneous=\"self\"//" $i #Remove AI-Elemtents

#remove jpg im metadata
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<xapGImg:image>([[:alnum:][:space:]\/+])*={0,2}[[:space:]]*<\/xapGImg:image>//g" $i

#Repair https://phabricator.wikimedia.org/T68672
sed -i "s/<style>/<style type=\"text\/css\">/" $i

#ArcMap-problems
sed -ri "s/<path d=\"m([[:digit:]hlmvz \.-]+)\" ([[:alnum:]\"= \.\(\)\#-]*)\" cbs=\"[[:digit:]GM]*\" gem=\"[[:alpha:]0 \.\(\)-]*\"\/>/<path d=\"m\1z\" \2\"\/>/g" $i


echo $i finish

done

