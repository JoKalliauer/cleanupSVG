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

for file in *.svg;do

echo $file

#export i=$file #i will be overritan later, just for debugging

export new="${file//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_]/}"

if [ $new == '*.svg' ]; then #new has to be controlled because it might have "-" which confuses bash
 echo "no file, (or filename does not contain any default latin character (a-z) )"
 break
fi


#export fileN=$(echo $new | cut -f1 -d" ") #remove spaces if exsiting (and everything after)
export tmp=$(echo $new | cut -f1 -d".")


#If you want to overwrite the exisiting file, without any backup, delete the following three lines
export i=${tmp}_.svg
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml

echo 
echo $i start:

#Define prepost equal to zero if not defined
if [ -z ${prepost+x} ]; then
 export prepost=0
fi

#Remove W3C-invalid elements
sed -ri "s/ text-align=\"(end|center)\"//g"  ${i}
sed -i "s/ aria-label=\"[[:digit:]]\"//g;s/ stroke-linejoin=\"null\"//g;s/ stroke-linecap=\"null\"//g;s/ stroke-width=\"null\"//g" $i
sed -i "s/ vector-effect=\"non-scaling-stroke\"//g;s/ solid-color=\"#000000\"//g" $i #QGIS-Files (made file valid)

#remove empty flow Text in svg (everything else will be done by https://github.com/JoKalliauer/cleanupSVG/blob/master/Flow2TextByInkscape.sh )
sed -i 's/<flowPara\/>//g;s/<flowRoot\/>//g' $i
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot>[[:space:]]*<flowRegion(\/|>[[:space:]]*<path d=\"[-[:digit:]hmvz\. ]*\"\/>[[:space:]]*<\/flowRegion)>[[:space:]]*(<flowDiv\/>|)[[:space:]]*<\/flowRoot>//g" $i #delete empty flowRoot
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" ]*)>[[:space:]]*(<path[-[:alnum:]\.=\"\ \#]*\/>|<rect( id=\"rect[-[:digit:]]{2,7}\"|) x=\"([[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([[:lower:][:digit:]=\.\" \#]+)\/>)[[:space:]]*<\/flowRegion>[[:space:]]*(<flowPara\/>|<flowPara([-[:alnum:]\.=\" \:\#; ]*)>([[:space:] ]*)<\/flowPara>)[[:space:]]*<\/flowRoot>//g" $i ##delete flowRoot only containing spaces

#sed -ri "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)><flowRegion([-[:alnum:]=:\" ]*)><rect( id=\"rect[-[:digit:]]{4,7}\"|) x=\"([[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([-[:lower:][:digit:]=\.\" \#]+)\/><\/flowRegion><flowPara([-[:alnum:]\.=\" \:\#;]*)>([-−[:alnum:] \{\}\+\ \ ]+)<\/flowPara><\/flowRoot>/<text x=\"\4\" y=\"\5\"\1><tspan x=\"\4\" y=\"\5\"\7>\8<\/tspan><\/text>/g" $i




#remove mostly useless elements
sed -ri "s/ letter-spacing=\"0([px]*)\"//g" $i
sed -ri "s/ word-spacing=\"0([px]*)\"//g" $i
sed -i "s/ stroke-width=\"1\"//g;s/ transform=\"scale(1)\"//g" $i
sed -i "s/ stroke-miterlimit=\"10\"//g" $i #Bug in IncscapePDFImport 

#add DOCTYPE
sed -i -e 's/<svg /\n<svg /' $i

if [ -z ${meta+x} ]; then
 #echo Metadata kept, no DOCTYPE added
 meta=0
fi


 if [ $meta != 1 ]; then  
  #echo add DTD
  if grep -qE "<svg ([[:lower:][:digit:]=\"\. -]*)version=\"1.0\"" $i; then
   sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\?>[[:space:]]*<svg/\?>\n<\!DOCTYPE svg PUBLIC \"-\/\/W3C\/\/DTD SVG 1.0\/\/EN\" \"http:\/\/www.w3.org\/TR\/2001\/REC-SVG-20010904\/DTD\/svg10.dtd\">\n<svg /' $i
  elif grep -qE "<svg ([[:lower:][:digit:]=\"\. -]*)version=\"1\"" $i; then
   sed -ri 's/<svg ([[:lower:][:digit:]=\"\. -]*)version=\"1\"/<svg \1version=\"1.0\"/' $i 
   sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\?>[[:space:]]*<svg/\?>\n<\!DOCTYPE svg PUBLIC \"-\/\/W3C\/\/DTD SVG 1.0\/\/EN\" \"http:\/\/www.w3.org\/TR\/2001\/REC-SVG-20010904\/DTD\/svg10.dtd\">\n<svg /' $i
  else
   sed -i -e ':a' -e 'N' -e '$!ba' -e "s/\?>[[:space:]]*<svg/\?>\n<\!DOCTYPE svg PUBLIC \'-\/\/W3C\/\/DTD SVG 1.1\/\/EN\' \'http:\/\/www.w3.org\/Graphics\/SVG\/1.1\/DTD\/svg11.dtd\'>\n<svg/" $i
   sed -ri 's/<svg ([[:lower:]=\"[:digit:] \.-]+) version="1.2" ([[:alnum:]=\" \.\/:]+)>/<svg \1 \2>/' $i
  fi
 #else
  #echo no DOCTYPE added
 fi
 
 if ! grep -qE "xmlns:xlink=" $i; then
  sed -ri 's/<svg/<svg xmlns:xlink="http:\/\/www.w3.org\/1999\/xlink"/' $i
 fi


#Change spaces to , in stroke-dasharray (solves librsvg-Bug https://phabricator.wikimedia.org/T32033 )
sed -ri 's/stroke-dasharray=\"([[:digit:]\.,]*)([[:digit:]\.]+) ([[:digit:]\., ]+)\"/stroke-dasharray=\"\1\2,\3\"/g' $i
sed -ri 's/stroke-dasharray=\"([[:digit:]\., ]*)([[:digit:]\.]+) ([[:digit:]\.,]+)\"/stroke-dasharray=\"\1\2,\3\"/g' $i

#sed -ri 's/stroke-dasharray=\"([[:digit:]\.,]+) ([[:digit:]\., ]+)\"/stroke-dasharray=\"\1,\2\"/g' $i
#sed -ri 's/stroke-dasharray=\"([[:digit:]\., ]+) ([[:digit:]\.,]+)\"/stroke-dasharray=\"\1,\2\"/g' $i

#Change "'font name'" to 'font name'(solves librsvg-Bug) https://commons.wikimedia.org/wiki/File:T184369.svg
sed -ri "s/font-family=\"'([-[:alnum:] ]*)'(|,[-[:lower:]]+)\"/font-family=\'\1\'/g" $i


#Change to Wikis Fallbackfont https://commons.wikimedia.org/wiki/Help:SVG#fallback to be compatible with https://meta.wikimedia.org/wiki/SVG_fonts
sed -ri 's/ font-family=\"(s|S)ans\"/ font-family=\"DejaVu Sans\"/g' $i #as automatic
sed -ri 's/ font-family=\"(s|S)erif\"/ font-family=\"DejaVu Serif\"/g' $i #as automatic
sed -ri 's/ font-family=\"(s|S)ans-(s|S)erif\"/ font-family=\"DejaVu Sans\"/g' $i #as automatic
sed -i 's/ font-family=\"Arial\"/ font-family=\"Liberation Sans\"/g' $i #as automatic
sed -i 's/ font-family=\"Arial,/ font-family=\"Liberation Sans,/g' $i #as automatic
sed -i 's/ font-family=\"Bitstream Vera Serif\"/ font-family=\"DejaVu Serif\"/g' $i #as automatic
sed -ri 's/ font-family=\"(Bitstream Vera Sans|DejaVuSans)\"/ font-family=\"DejaVu Sans\"/g' $i #as automatic
sed -i 's/ font-family=\"Bitstream Vera Sans Mono\"/ font-family=\"DejaVu Sans Mono\"/g' $i #as automatic
sed -i 's/ font-family=\"Times New Roman\"/ font-family=\"Liberation Serif\"/g' $i #as automatic
#sed -i 's/ font-family=\"Albany embedded\"/ font-family=\"Loma\"/g' $i #as automatic
sed -ri "s/<(text|g)([-[:lower:][:digit:]\.=\"\ \#\(\)]*) font-family=\"DejaVu Sans Condensed\"([-[:lower:][:digit:]=\"\ \#]*)>/<\1\2 font-family=\"DejaVu Sans\" font-stretch=\"condensed\"\3>/g" $i # correct syntax
sed -i 's/ font-family=\"Helvetica\"/ font-family=\"Garuda\"/g' $i #looks similar https://commons.wikimedia.org/wiki/File_talk:Meta_SVG_fonts.svg
#sed -i 's/ fill=\"#002060\" font-family=\"Swis721 BlkCn BT\" font-size=\"/ fill=\"#002060\" font-family=\"Liberation Sans\" font-weight=\"bold\" font-size=\"/g' $i #looks similar https://www.dafontfree.net/freefonts-swis721-blkcn-bt-f61164.htm
#sed -i "s/ font-family=\"Blue Highway\"/ font-family=\"Padauk\"/g" $i #looks similar https://www.dafont.com/de/blue-highway.font
#sed -i "s/ font-family=\"Blue Highway Condensed\"/ font-family=\"Padauk\" font-stretch=\"condensed\"/g" $i
#sed -i "s/ font-family=\"Blue Highway D Type\"/ font-family=\"Padauk\" text-transform=\"uppercase\"/g" $i
#sed -i "s/ font-family=\"TiepoloStd-BookItalic\"/ font-family=\"Garuda\" font-style=\"italic\"/g" $i
#sed -i "s/ font-family=\"BenguiatStd-Book\"/ font-family=\"Garuda\"/g" $i
#sed -i "s/ font-family=\"TiepoloStd-Bold\"/ font-family=\"Garuda\" font-weight=\"bold\"/g" $i
#sed -i "s/ font-family=\"TiepoloStd-BoldItalic\"/ font-family=\"Garuda\" font-weight=\"bold\" font-style=\"italic\"/g" $i
#sed -i "s/ font-family=\"SanvitoPro-Regular\"/ font-family=\"Garuda\"/g" $i
#sed -i "s/ font-family=\"Helvetica-BoldOblique\"/ font-family=\"Garuda\" font-weight=\"bold\" font-style=\"oblique\"/g" $i
#sed -i "s/ font-family=\"BenguiatStd-BookItalic\"/ font-family=\"Garuda\" font-style=\"italic\"/g" $i
#sed -i "s/ font-family=\"TiepoloStd-Book\"/ font-family=\"Garuda\"/g" $i
sed -i "s/ font-family=\"Tiepolo\"/ font-family=\"Liberation Sans\"/g" $i
sed -i "s/ font-family=\"Benguiat\"/ font-family=\"Liberation Sans\"/g" $i
sed -i "s/ font-family=\"Sanvito\"/ font-family=\"Liberation Sans\"/g" $i
sed -i "s/ font-family=\"Helvetica\"/ font-family=\"Liberation Sans\"/g" $i

#sed -i "s/ font-family=\"Nimbus Mono L\"/ font-family=\"TlwgMono\"/g" $i #looks similar https://en.wikipedia.org/wiki/Nimbus_Mono_L
#sed -ri 's/ font-family=\"Benguiat\"/ font-family=\"Tibetan Machine Uni\"/g' $i #looks similar # http://www.fontpalace.com/font-details/Benguiat+Bold/
#sed -ri 's/ font-family=\"Sanvito\"/ font-family=\"Purisa\"/g' $i #looks similar # https://www.myfonts.com/fonts/adobe/sanvito/
#sed -ri 's/ font-family=\"Tiepolo\"/ font-family=\"Norasi\"/g' $i #looks similar # https://www.myfonts.com/fonts/itc/tiepolo/
sed -ri 's/ font-family=\"DejaVu Sans Bold\"/ font-family=\"DejaVu Sans\" font-weight=\"bold\"/g' $i
sed -ri 's/ font-family=\"(Arial|Myriad Pro|ArialNarrow|ArialMT)\"/ font-family=\"Liberation Sans\"/g' $i #all Sans to Liberation
sed -ri 's/ font-family=\"(Minion Pro|Times|Times New Roman|SVGTimes)\"/ font-family=\"Liberation Serif\"/g' $i #all Serif to Liberation
#sed -ri 's/ font-family=\"Dialog\"/ font-family=\"DejaVu Sans\"/g' $i #unknown fonts to DejaVu Sans



#simpifying text
#sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<tspan/\n<tspan/g" $i
#sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>/<\/tspan>\n/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\" y=\"([-[:digit:]\. ]+)\"([-[:alnum:]\.\"\#\ =]*)>/<tspan x=\"\2\" y=\"\5\"\1\6>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<text x=\"([-[:digit:]\.]+) ([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([-[:alnum:]\.\"\#\ =]*)>/<text x=\"\1\" y=\"\3\"\4>/g" $i # remove multipe x-koordinates in text (solves librsvg-Bug)
#sed -ri "s/<text x=\"([[:digit:]\. ]+)\" y=\"([[:digit:]\.]+) ([[:digit:]\. ]+)\"([-[:alnum:] =\"]*)>/<text x=\"\1\" y=\"\2\"\4>/g" $i #remove multiple y-koordinates in text
#sed -ri "s/<text([xy\ [:digit:]\"\.\=]*) fill=\"\#[[:xdigit:]]{3,6}\"/<text\1/g" $i #remove fill in text
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<text([[:lower:][:digit:]= #,-\,\"\-\.\(\)]*)>[[:space:]]*<tspan/<text\1><tspan/g" $i #remove spaces and linebreaks between text and tspan
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>[[:space:]]*<\/text>/<\/tspan><\/text>/g" $i #remove spaces and linebreaks between text and tspan
#sed -i -e ':a' -e 'N' -e '$!ba' -e "s/\n<tspan/<tspan/g" $i #remove lineforward before tspan
#sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<tspan/\n<tspan/g" $i #add lineforward before tspan
#sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>[[:space:]]+<tspan /<\/tspan> <tspan /g" $i #reduces multiple spaces to one space
sed -ri "s/<text ([-[:lower:][:digit:].,\"= ]+) xml:space=\"preserve\">([-[:alnum:]\\\$\']+)<\/text>/<text \1>\2<\/text>/g" $i #remove xml:space="preserve" in text if unnecesarry
sed -ri 's/<text [-[:lower:][:digit:]= \"\:\.]+\/>//g' $i #remove empty text
sed -ri 's/<tspan [-[:lower:][:digit:]= \"\.]+\/>//g' $i #remove empty tspan
sed -i "s/<tspan x=\"0\" y=\"0\">/<tspan>/g" $i #reduce options in tspan
sed -ri "s/<tspan>([]\[[:alnum:]\$\^\\\_\{\}= #\,\"\.\(\)\’\&\;\/Επιβάτες¸−-]*)<\/tspan>([ ]*)/\1/g" $i #remove unnecesarry <tspan>...</tspan> without attributes
sed -ri "s/<tspan[-[:lower:][:digit:]= \"\.]+> <\/tspan>([ ]*)//g" $i #remove useless <tspan (...)> </tspan> without text


#two lineforward to one lineforward
sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\n\n/\n/g' $i

#Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/=\"([amp38;\#\&\])+ns_flows;\"/=\"http:\/\/ns.adobe.com\/Flows\/1.0\/\"/g" $i 
sed -ri "s/ xmlns:x=\"([amp38;\#\&\])+ns_extend;\"/ xmlns:x=\"http:\/\/ns.adobe.com\/Extensibility\/1.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/=\"([amp38;\#\&\])+ns_ai;\"/=\"http:\/\/ns.adobe.com\/AdobeIllustrator\/10.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/ xmlns:graph=\"([amp38;\#\&\])+ns_graphs;\"/ xmlns:graph=\"http:\/\/ns.adobe.com\/Graphs\/1.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/=\"([amp38;\#\&\])+ns_vars;\"/=\"http:\/\/ns.adobe.com\/Variables\/1.0\/\"/g" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/=\"([amp38;\#\&\])+ns_imrep;\"/=\"http:\/\/ns.adobe.com\/ImageReplacement\/1.0\/\"/g" $i #	<!ENTITY ns_imrep "http://ns.adobe.com/ImageReplacement/1.0/">
sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_sfw;\"/ xmlns=\"http:\/\/ns.adobe.com\/SaveForWeb\/1.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_custom;\"/ xmlns=\"http:\/\/ns.adobe.com\/GenericCustomNamespace\/1.0\/\"/" $i
#	<!ENTITY ns_adobe_xpath "http://ns.adobe.com/XPath/1.0/">
sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_svg;\"/ xmlns=\"http:\/\/www.w3.org\/2000\/svg\"/" $i
sed -ri "s/ xmlns:xlink=\"([amp38;\#\&\])+ns_xlink;\"/ xmlns:xlink=\"http:\/\/www.w3.org\/1999\/xlink\"/" $i

sed -i "s/<?xpacket begin='﻿' id='/<?xpacket begin='ZeichenEingefuegtVonKalliauer' id='/g" $i

#CorelDraw-Problem
sed -i "s/ href=\"#id/ xlink:href=\"#id/g" $i


#Remove CDATA by AdobeIllustrator
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
sed -ri "s/<mask id=\"([[:alpha:]]+)\"([[:lower:] =\"[:digit:]]*) maskUnits=\"userSpaceOnUse\">/<mask id=\"\1\" \2>/g" $i

#ArcMap-problems (made file valid, removes cbs= and gem=)
sed -ri "s/<path d=\"m([[:digit:]hlmvz \.-]+)\" ([[:alnum:]\"= \.\(\)\#-]*)\" cbs=\"[[:digit:]GM]*\" gem=\"[[:alpha:]0 \.\(\)-]*\"\/>/<path d=\"m\1\" \2\"\/>/g" $i


#suggestions from https://en.wikipedia.org/wiki/Wikipedia:SVG_help
sed -i "s/Sans embedded/DejaVu Sans/g" $i
#sed -ri "s/font-size:([0-9]*);/font-size:\1px;/g" $i
sed -ri "s/tspan x=\"([0-9]*) ([0-9 ]*)\"/tspan x=\"\1\"/g" $i
sed -ri "s/<g style=\"stroke:none;fill:none\"><text>/<g style=\"stroke:none;fill:rgb(0,0,0)\"><text>/g" $i


#font-face{font-family:&quot;Liberation Serif&quot;;

#svgo to cleaner
sed -ri "s/font-family:&quot;([-[:alnum:] ]*)&quot;/font-family:\"\1\"/g" $i
sed -ri "s/font-family:&apos;([-[:alnum:] ]*)&apos;/font-family:'\1'/g" $i


#mv $i ${tmp}_.svg
echo $i finish



done

