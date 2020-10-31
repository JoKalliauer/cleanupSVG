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

chmod u+r *
chmod u+rx *.sh

for file in *.svg;do
chmod u+r "${file}"
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
export i=${tmp}p.svg
chmod u+r ./"${file}"
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml

echo 
echo $i start:

#  #  # #Define prepost equal to zero if not defined
#  #  # if [ -z ${prepost+x} ]; then
#  #  #  export prepost=0
#  #  # fi
#  #  
#  #  
#  #  
#  #  #Remove W3C-invalid elements
#  #  sed -ri "s/ text-align=\"(end|center)\"//g"  ${i}
#  #  sed -i "s/ aria-label=\"[[:digit:]]\"//g;s/ stroke-linejoin=\"null\"//g;s/ stroke-linecap=\"null\"//g;s/ stroke-width=\"null\"//g" $i
#  #  #sed -i "s/ solid-color=\"#000000\"//g" $i #QGIS-Files (made file valid)
#  #  
#  #  # <flowPara font-family="Liberation Sans" font-size="55.071px" style="line-height:125%"/>
#  #  
#  #  # <flowPara id="flowPara10507" style="fill:url(#linearGradient11781)"/>
#  #  
#  #  #remove empty flow Text in svg (everything else will be done by https://github.com/JoKalliauer/cleanupSVG/blob/master/Flow2TextByInkscape.sh )
#  #  #    <flowRoot id="flowRoot3750" style="fill:black;font-family:Linux Libertine;font-size:64;line-height:100%;text-align:center;text-anchor:middle;writing-mode:lr" xml:space="preserve"/>
#  #  sed -ri 's/<flowPara([-[:alnum:]\" \.\:\%\=\;#\(\)]*)\/>//g;s/<flowRoot([-[:alnum:]" \.:%=;]*)\/>//g' $i
#  #  sed -i 's/<flowSpan[-[:alnum:]=\":;\. ]*>[[:space:]]*<\/flowSpan>//g' $i
#  #  sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion(\/|[[:alnum:]\"= ]*>[[:space:]]*<(path|rect) [-[:alnum:]\. \"\=:]*\/>[[:space:]]*<\/flowRegion)>[[:space:]]*(<flowDiv\/>|)[[:space:]]*<\/flowRoot>//g" $i #delete empty flowRoot
#  #  sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" ]*)>[[:space:]]*(<path[-[:alnum:]\.=\"\ \#]*\/>|<rect( id=\"[-[:alnum:]]*\"|) x=\"([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([[:lower:][:digit:]=\.\" \#:]+)\/>)[[:space:]]*<\/flowRegion>[[:space:]]*(|<flowPara([-[:alnum:]\.=\" \:\#;% ]*)>([[:space:] ]*)<\/flowPara>)[[:space:]]*<\/flowRoot>//g" $i ##delete flowRoot only containing spaces
#  #  
#  #  
#  #  #remove mostly useless elements
#  #  sed -ri "s/ letter-spacing=\"0([px]*)\"//g" $i
#  #  sed -ri "s/ word-spacing=\"0([px]*)\"//g" $i
#  #  sed -i "s/ stroke-width=\"1\"//g;s/ transform=\"scale(1)\"//g" $i
#  #  sed -i "s/ stroke-miterlimit=\"10\"//g" $i #Bug in IncscapePDFImport 
#  #  
#  #  #add DOCTYPE
#  #  sed -i -e 's/<svg /\n<svg /' $i
#  #  
#  #  if [ -z ${meta+x} ]; then
#  #   #echo Metadata kept, no DOCTYPE added
#  #   meta=0
#  #  fi
#  #  
#  #  
#  #   if [ $meta != 1 ]; then  
#  #    #echo add DTD
#  #    if grep -qE "<svg([[:lower:][:digit:]=\"\. -]*) version=\"1.0\"" $i; then
#  #     echo Version10
#  #     sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\?>[[:space:]]*<svg/\?>\n<\!DOCTYPE svg PUBLIC \"-\/\/W3C\/\/DTD SVG 1.0\/\/EN\" \"http:\/\/www.w3.org\/TR\/2001\/REC-SVG-20010904\/DTD\/svg10.dtd\">\n<svg /' $i
#  #    elif grep -qE "<svg ([[:lower:][:digit:]=\"\. -]*)version=\"1\"" $i; then
#  #     echo Version1
#  #     sed -ri 's/<svg ([[:lower:][:digit:]=\"\. -]*)version=\"1\"/<svg \1version=\"1.0\"/' $i 
#  #     sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\?>[[:space:]]*<svg/\?>\n<\!DOCTYPE svg PUBLIC \"-\/\/W3C\/\/DTD SVG 1.0\/\/EN\" \"http:\/\/www.w3.org\/TR\/2001\/REC-SVG-20010904\/DTD\/svg10.dtd\">\n<svg /' $i
#  #    else
#  #     #echo noVersionDetected
#  #     sed -i -e ':a' -e 'N' -e '$!ba' -e "s/\?>[[:space:]]*<svg/\?>\n<\!DOCTYPE svg PUBLIC \'-\/\/W3C\/\/DTD SVG 1.1\/\/EN\' \'http:\/\/www.w3.org\/Graphics\/SVG\/1.1\/DTD\/svg11.dtd\'>\n<svg/" $i
#  #     sed -ri 's/<svg ([[:lower:]=\"[:digit:] \.-]+) version="1.2" ([[:alnum:]=\" \.\/:]+)>/<svg \1 \2>/' $i
#  #    fi
#  #   #else
#  #    #echo no DOCTYPE added
#  #   fi
#  #   
#  #  # if ! grep -qE "xmlns:xlink=" $i; then
#  #  #  sed -ri 's/<svg/<svg xmlns:xlink="http:\/\/www.w3.org\/1999\/xlink"/' $i
#  #  # fi
#  #  
#  #  ## ==Change Fonts to WikiFonts ==
#  #  
#  #  #Change to Wikis Fallbackfont https://commons.wikimedia.org/wiki/Help:SVG#fallback to be compatible with https://meta.wikimedia.org/wiki/SVG_fonts
#  #  sed -ri 's/ font-family=\"(s|S)ans\"/ font-family=\"DejaVu Sans,sans-serif,Sans\"/g' $i #as automatic
#  #  sed -ri 's/ font-family=\"(s|S)erif\"/ font-family=\"DejaVu Serif,serif\"/g' $i #as automatic
#  #  sed -ri 's/ font-family=\"(s|S)ans-(s|S)erif\"/ font-family=\"DejaVu Sans,sans-serif\"/g' $i #as automatic
#  #  sed -i 's/ font-family=\"Arial/ font-family=\"Liberation Sans,Arial/g' $i #as automatic
#  #  sed -i 's/ font-family=\"Times New Roman\"/ font-family=\"Liberation Serif,Times New Roman\"/g' $i #as automatic
#  #  
#  #  
#  #  #simpifying text
#  #  sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<text([[:lower:][:digit:]= #,-\,\"\-\.\(\)]*)>[[:space:]]*<tspan/<text\1><tspan/g" $i #remove spaces and linebreaks between text and tspan
#  #  sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>[[:space:]]*<\/text>/<\/tspan><\/text>/g" $i #remove spaces and linebreaks between text and tspan
#  #  sed -ri "s/<text ([-[:lower:][:digit:].,\"= ]+) xml:space=\"preserve\">([-[:alnum:]\\\$\']+)<\/text>/<text \1>\2<\/text>/g" $i #remove xml:space="preserve" in text if unnecesarry
#  #  sed -ri 's/<text [-[:lower:][:digit:]= \"\:\.\(\)]+\/>//g' $i #remove selfclosing text
#  #  sed -ri 's/<tspan [-[:lower:][:digit:]= \"\.\:\;\%#]+\/>//g' $i #remove selfclosing tspan
#  #  sed -i "s/<tspan x=\"0\" y=\"0\">/<tspan>/g" $i #reduce options in tspan
#  #  sed -ri "s/<tspan>([]\[[:alnum:]\$\^\\\_\{\}= #\,\"\.\(\)\’\&\;\/Επιβάτες¸\°\'\"\@\:−-]*)<\/tspan>([ ]*)/\1/g" $i #remove unnecesarry <tspan>...</tspan> without attributes
#  #  sed -ri "s/<tspan[-[:alnum:]= \"\.#\(\);:,\'%]*>[[:space:]]*<\/tspan>([ ]*)//g" $i #remove useless,empty <tspan (...)> </tspan> without text
#  #  
#  #  #selfclosing groups
#  #  sed -i "s/<g[-[:alnum:]=\"\(\)\.,_ :]*\/>/ /g" $i
#  #  
#  #  #two lineforward to one lineforward
#  #  sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\n\n/\n/g' $i

#Inkscape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/=\"([amp38;\#\&\])+ns_flows;\"/=\"http:\/\/ns.adobe.com\/Flows\/1.0\/\"/g" $i 
sed -ri "s/ xmlns:x=\"([amp38;\#\&\])+ns_extend;\"/ xmlns:x=\"http:\/\/ns.adobe.com\/Extensibility\/1.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right (or maybe xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml")
sed -ri "s/=\"([amp38;\#\&\])+ns_ai;\"/=\"http:\/\/ns.adobe.com\/AdobeIllustrator\/10.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/ xmlns:graph=\"([amp38;\#\&\])+ns_graphs;\"/ xmlns:graph=\"http:\/\/ns.adobe.com\/Graphs\/1.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/=\"([amp38;\#\&\])+ns_vars;\"/=\"http:\/\/ns.adobe.com\/Variables\/1.0\/\"/g" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/=\"([amp38;\#\&\])+ns_imrep;\"/=\"http:\/\/ns.adobe.com\/ImageReplacement\/1.0\/\"/g" $i #	<!ENTITY ns_imrep "http://ns.adobe.com/ImageReplacement/1.0/">
sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_sfw;\"/ xmlns=\"http:\/\/ns.adobe.com\/SaveForWeb\/1.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_custom;\"/ xmlns=\"http:\/\/ns.adobe.com\/GenericCustomNamespace\/1.0\/\"/" $i
#	<!ENTITY ns_adobe_xpath "http://ns.adobe.com/XPath/1.0/">
sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_svg;\"/ xmlns=\"http:\/\/www.w3.org\/2000\/svg\"/" $i
sed -ri "s/ xmlns:xlink=\"([amp38;\#\&\])+ns_xlink;\"/ xmlns:xlink=\"http:\/\/www.w3.org\/1999\/xlink\"/" $i
#https://www.w3.org/TR/2000/WD-CCPP-vocab-20000721/
#  <!ENTITY ns-rdf  'http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
#  <!ENTITY ns-rdfs 'http://www.w3.org/2000/01/rdf-schema#'>
#  <!ENTITY ns-ccpp 'http://www.w3.org/2000/07/04-ccpp#'>
#  <!ENTITY ns-ccpp-proxy 'http://www.w3.org/2000/07/04-ccpp-proxy#'>
#  <!ENTITY ns-ccpp-client 'http://www.w3.org/2000/07/04-ccpp-client#'>
#  <!ENTITY ns-uaprof 'http://www.wapforum.org/UAPROF/ccppschema-19991014#'>

sed -i "s/<?xpacket begin='﻿' id='/<?xpacket begin='ZeichenEingefuegtVonKalliauer' id='/g" $i

#  #  #CorelDraw-Problem (not very common)
#  #  #sed -i "s/ href=\"#id/ xlink:href=\"#id/g" $i
#  #  
#  #  
#  #  #Remove CDATA by AdobeIllustrator
#  #  sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\!\[CDATA\[([[:alnum:]=+\/\t\n[:space:]@:;\(\)\"\,\'\{\}\-])*\t\]\]>[[:space:]]*//g" $i #Remove CDATA
#  #  sed -ri "s/<i:pgfRef xlink:href=\"#a([[:lower:]_]*)\"\/>//" $i #Remove AI-Elemtents for CDATA
#  #  sed -i "s/<i:pgf id=\"a\"\/>//" $i #Remove AI-Elemtents for CDATA
#  #  sed -ri -e ':a' -e 'N' -e "s/<i:pgf( ){1,2}id=\"a([[:lower:]_])*\">[[:space:]]*<\/i:pgf>//" $i #Remove AI-Elemtents for CDATA
#  #  sed -i "s/ i:extraneous=\"self\"//" $i #Remove AI-Elemtents
#  #  
#  #  #remove jpg im metadata
#  #  sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<xapGImg:image>([[:alnum:][:space:]\/+])*={0,2}[[:space:]]*<\/xapGImg:image>//g" $i
#  #  
#  #  # == make file valid ==
#  #  
#  #  # font-weight="630"
#  #  #sed -i "s/ font-weight=\"630\"/ font-weight=\"bold\"/g" $i
#  #  
#  #  #ArcMap-problems (made file valid, removes cbs= and gem=)
#  #  #sed -ri "s/<path d=\"m([[:digit:]hlmvz \.-]+)\" ([[:alnum:]\"= \.\(\)\#-]*)\" cbs=\"[[:digit:]GM]*\" gem=\"[[:alpha:]0 \.\(\)-]*\"\/>/<path d=\"m\1\" \2\"\/>/g" $i
#  #  
#  #  #invalid id-names
#  #  #sed -ri "s/ <(g|path|text) id=\"([-[:alnum:]:_\.]*)( |'|\(|\)|&|#|,|\/)([-[:alnum:] \':_|\(|\)|&.,\/]+)\"/ <\1 id=\"\2_\4\"/" $i #replaces (spaces and commas and /) with underlines
#  #  #sed -ri "s/ <(g|path|text) id=\"([-[:alnum:]:_\.]+)( |'|\(|\)|&|#|,|\/)([-[:alnum:] \':_|\(|\)|&.,\/]+)\"/ <\1 id=\"\2_\4\"/" $i #replaces spaces with underlines
#  #  #sed -ri "s/ <(g|path|text) id=\"([-[:alnum:]:_\.]+)( |'|\(|\)|&|#|,|\/)([-[:alnum:] \':_|\(|\)|&.,\/]+)\"/ <\1 id=\"\2_\4\"/" $i #replaces spaces with underlines
#  #  #sed -ri "s/ <(g|path|text) id=\"([-[:alnum:]:_\.]+)( |'|\(|\)|&|#|,|\/)([-[:alnum:] \':_|\(|\)|&.,\/]*)\"/ <\1 id=\"\2_\4\"/" $i #replaces spaces with underlines
#  #  # do not use this line # sed -ri "s/ <(g|path) id=\"([[:digit:]]+)\"/ <\1 id=\"FIPS_\2\"/" $i #valid id names must not start with a number
#  #  
#  #  # there is no attribute "data-name" (SVG 2.0)
#  #  sed -ri "s/<(svg|symbol|path|use|g)([[:alnum:]=\"\.\/ -:]*) data-name=\"[[:alnum:] ]+\"/<\1\2/" $i
#  #  
#  #  
#  #  #suggestions from https://en.wikipedia.org/wiki/Wikipedia:SVG_help
#  #  sed -i "s/Sans embedded/DejaVu Sans/g" $i
#  #  sed -ri "s/tspan x=\"([0-9]*) ([0-9 ]*)\"/tspan x=\"\1\"/g" $i
#  #  sed -ri "s/<g style=\"stroke:none;fill:none\"><text>/<g style=\"stroke:none;fill:rgb(0,0,0)\"><text>/g" $i

## == Workaround for inkscape bug ==
 sed -ri "s/inkscape:version=\"0.(4[\. r[:digit:]]+|91 r13725)\"//g" $i # https://bugs.launchpad.net/inkscape/+bug/1763190

#  #  ## == Repair after svgo ==
#  #  
#  #  #svgo to cleaner
#  #  sed -ri "s/font-family:&quot;([-[:alnum:] ]*)&quot;/font-family:\"\1\"/g" $i
#  #  sed -ri "s/font-family:&apos;([-[:alnum:] ]*)&apos;/font-family:'\1'/g" $i
#  #  
#  #  ## == Workarounds for Librsvg ==
#  #  
#  #  #Repair WARNING in <mask> with id=ay: Mask element found with maskUnits set. It will not be rendered properly by Wikimedia's SVG renderer. See https://phabricator.wikimedia.org/T55899 for details
#  #  sed -ri "s/<mask([[:alnum:] =\"]*) maskUnits=\"userSpaceOnUse\"( id=\"[[:alnum:]_]+\"|)>/<mask\1\2>/g" $i
#  #  
#  #  
#  #  #Change spaces to , in stroke-dasharray (solves librsvg-Bug https://phabricator.wikimedia.org/T32033 )
#  #  sed -ri 's/stroke-dasharray=\"([[:digit:]\.,]*)([[:digit:]\.]+) ([[:digit:]\., ]+)\"/stroke-dasharray=\"\1\2,\3\"/g' $i
#  #  sed -ri 's/stroke-dasharray=\"([[:digit:]\., ]*)([[:digit:]\.]+) ([[:digit:]\.,]+)\"/stroke-dasharray=\"\1\2,\3\"/g' $i
#  #  
#  #  #Change "'font name'" to 'font name'(solves librsvg-Bug) https://commons.wikimedia.org/wiki/File:T184369.svg
#  #  sed -ri "s/font-family=\"'([-[:alnum:] ]*)'(|,[-[:lower:]]+)\"/font-family=\'\1\'/g" $i
#  #  
#  #  # multiple x-koordinates https://phabricator.wikimedia.org/T35245
#  #  #sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:]])/<tspan x=\"\2\" \1 \5>\6<\/tspan><tspan x=\"\4\" \1 \5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
#  #  #sed -ri "s/<text([-[:alnum:]\.\"\#\ =\(\)]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =\,]*)>/<text x=\"\2\"\1\5>/g" $i # remove multipe x-koordinates in text (solves librsvg-Bug)
#  #  #sed -ri "s/<text([-[:alnum:]\.\"\#\ =\(\)]*) y=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =\,]*)>/<text y=\"\2\"\1\5>/g" $i # remove multipe y-koordinates in text (solves librsvg-Bug)
#  #  
#  #  #Repair https://phabricator.wikimedia.org/T68672 (solves librsvg-Bug)
#  #  sed -i "s/<style>/<style type=\"text\/css\">/" $i
#  #  
#  #  #solved librsvg-Bug T193929 https://phabricator.wikimedia.org/T193929
#  #  sed -i "s/ xlink:href=\"data:image\/jpg;base64,/ xlink:href=\"data:image\/jpeg;base64,/g" $i
#  #  sed -i "s/ xlink:href=\"data:;base64,\/9j\/4AAQSkZJRgABAgAAZABkAAD\/7AARRHVja3kAAQAEAAAAHgAA/ xlink:href=\"data:image\/jpeg;base64,\/9j\/4AAQSkZJRgABAgAAZABkAAD\/7AARRHVja3kAAQAEAAAAHgAA/" $i
#  #  sed -ri "s/ xlink:href=\"data:;base64,( |)iVBORw0KGgoAAAANSUhEUgAA/ xlink:href=\"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAA/" $i
#  #  
#  #  #solved librsvg-Bug T194192 https://phabricator.wikimedia.org/T194192
#  #  #<svg font-family="ScriptS" font-size="5" viewBox="0,0,128,128"
#  #  sed -ri "s/<svg([-[:alnum:]=\" ]*) viewBox=\"0,0,([[:digit:]\.]*),([[:digit:]\.]*)\"/<svg\1 viewBox=\"0 0 \2 \3\"/g" $i
#  #  
#  #  #librsvgbug https://phabricator.wikimedia.org/phab:T207506 (<code>font-weight="normal"</code> ignored)
#  #  sed -ri "s/font-weight=\"normal\"/font-weight=\"400\"/g" $i
#  #  
#  #  

## == unsave uploads
#https://commons.wikimedia.org/wiki/Commons:Help_desk#Found_unsafe_CSS_in_the_style_element_of_uploaded_SVG_file
sed -i "s/src: url(\"data:font\/woff;charset=utf-8;base64,data:application\/x-font-ttf;base64,AAEAAAAQAQAABAAAR[[:alnum:]+\/]*\");//" $i

echo $i finish



done

