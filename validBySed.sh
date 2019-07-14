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
export i=${tmp}v.svg
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml

echo 
echo $i start:


## == https://validator.w3.org/check and https://validator.nu/ ==
# W3C: there is no attribute "line-height"
# Nu:   Attribute text-align not allowed on SVG element text at this point.
## example     <text id="text8220" x="126.62" y="85.62" style="letter-spacing:0;line-height:125%;text-align:center;text-anchor:middle;word-spacing:0" line-height="125%" sodipodi:linespacing="125%"><tspan id="tspan8222" x="126.62" y="85.62">1</tspan></text>
## example:   <text id="text2998" fill="#f0ff8f" fill-opacity=".941" font-size="1.32" line-height="125%" stroke-width=".165" x="-91.4" xml:space="preserve" y="-40.85">    <tspan id="tspan2996" fill="#f0ff8f" fill-opacity=".941" stroke-width=".165" x="-91.4" y="-40.85">2.19</tspan></text>
#svgcleaner or svgo
sed -ri "s/<(text|tspan)([-[:alnum:]=\.\" \(\)\':;%#]*) line-height=\"[0123569.%]+\"/<\1\2/g" $i

#W3C: Warning:  DOCTYPE Override in effect!
# Nu: Warning: Unsupported SVG version specified. This validator only supports SVG 1.1. The recommended way to suppress this warning is to remove the version attribute altogether.
  if grep -qE "<svg([[:lower:][:digit:]=\"\. -]*) version=\"1.0\"" $i; then
   echo Version10
   sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\?>[[:space:]]*<svg/\?>\n<\!DOCTYPE svg PUBLIC \"-\/\/W3C\/\/DTD SVG 1.0\/\/EN\" \"http:\/\/www.w3.org\/TR\/2001\/REC-SVG-20010904\/DTD\/svg10.dtd\">\n<svg /' $i
  elif grep -qE "<svg ([[:lower:][:digit:]=\"\. -]*)version=\"1\"" $i; then
   echo Version1
   sed -ri 's/<svg ([[:lower:][:digit:]=\"\. -]*)version=\"1\"/<svg \1version=\"1.0\"/' $i 
   sed -i -e ':a' -e 'N' -e '$!ba' -e 's/\?>[[:space:]]*<svg/\?>\n<\!DOCTYPE svg PUBLIC \"-\/\/W3C\/\/DTD SVG 1.0\/\/EN\" \"http:\/\/www.w3.org\/TR\/2001\/REC-SVG-20010904\/DTD\/svg10.dtd\">\n<svg /' $i
  fi
 
#W3C: there is no attribute "text-align"
#Nu: Attribute text-align not allowed on SVG element text at this point.
##example: <text id="text308" stroke-width=".165" text-anchor="end" x="21.91" xml:space="preserve" y="16.21" text-align="end">   <tspan id="tspan304" stroke-width=".165" text-anchor="end" x="21.91" y="16.21" text-align="end">+1</tspan><tspan id="tspan306" stroke-width=".165" text-anchor="end" x="21.91" y="17.46" text-align="end">−1</tspan></text>
## example:  <text id="text42" font-weight="bold" stroke-width=".165" text-anchor="middle" x="16.08" xml:space="preserve" y="22.33" text-align="center"/>
sed -ri "s/ text-align=\"(end|center)\"//g"  ${i}

 
#W3C: element "rdf:RDF" undefined
#Nu: Warning: This validator does not validate RDF. RDF subtrees go unchecked.
# use scour/svgcleaner/svgo or https://de.wikipedia.org/wiki/Benutzer:Marsupilami/Inkscape-FAQ#Wie_erstelle_ich_eine_Datei_die_dem_Standard_SVG_1.1_entspricht?
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/[[:space:]\r\n]*<rdf:RDF>[[:space:]\r\n]*<cc:Work( rdf:about=\"\"|)>[[:space:]\r\n]*(<dc:format>[[:space:]\r\n]*image\/svg\+xml[[:space:]\r\n]*<\/dc:format>|<dc:format\/>)[[:space:]\r\n]*<dc:type rdf:resource=\"http:\/\/purl.org\/dc\/dcmitype\/StillImage\"\/>([[:space:]\r\n]*<dc:title\/>|)[[:space:]\r\n]*<\/cc:Work>[[:space:]\r\n]*<\/rdf:RDF>//" $i
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<metadata( id=\"metadata[[:digit:]]*\"|)>[[:space:]\r\n]*<\/metadata>//" $i
   

#W3C: Error: there is no attribute "sodipodi:version"
#W3C: Error: element "sodipodi:namedview" undefined
#W3C: Error: element "inkscape:perspective" undefined
#W3C: Error:  there is no attribute "inkscape:collect"
#W3C: Error: there is no attribute "sodipodi:cx"
#W3C: Error: there is no attribute "inkscape:label"
#W3C: Error:  there is no attribute "sodipodi:nodetypes"
#W3C: Error: there is no attribute "inkscape:connector-curvature"
#Nu: Warning: This validator does not validate Inkscape extensions properly. Inkscape-specific errors may go unnoticed.
# use scour
# use svgcleaner --remove-nonsvg-attributes yes --remove-nonsvg-elements yes
# use svgo
 sed -i "s/ inkscape:connector-curvature=\"0\"//g" $i
 #<sodipodi:namedview bordercolor="#666666" borderopacity="1" gridtolerance="10" guidetolerance="10" inkscape:current-layer="svg2" inkscape:cx="398.5" inkscape:cy="96.5" inkscape:pageopacity="0" inkscape:pageshadow="2" inkscape:window-height="480" inkscape:window-maximized="0" inkscape:window-width="640" inkscape:window-x="0" inkscape:window-y="0" inkscape:zoom="0.36010038" objecttolerance="10" pagecolor="#ffffff" showgrid="false"/>
   sed -ri "s/<sodipodi:namedview( id=\"namedview[[:digit:]]*\"|) bordercolor=\"#666666\" borderopacity=\"1\" gridtolerance=\"10\" guidetolerance=\"10\" inkscape:current-layer=\"[[:digit:]svgEbene_]*\" inkscape:cx=\"[-[:digit:].]*\" inkscape:cy=\"[-[:digit:].]*\" inkscape:pageopacity=\"0\" inkscape:pageshadow=\"2\" inkscape:window-height=\"(480|1017)\" inkscape:window-maximized=\"(0|1)\" inkscape:window-width=\"(640|1920)\" inkscape:window-x=\"(0|-8)\" inkscape:window-y=\"(0|-8)\" inkscape:zoom=\"[[:digit:].]*\" objecttolerance=\"10\" pagecolor=\"#ffffff\"( showgrid=\"false\"|)\/>//" $i

#W3C: Error:  there is no attribute "enable-background"
#Nu: Error: Attribute enable-background not allowed on SVG element path at this point.
#use svgcleaner --remove-needless-attributes yes

#W3C: there is no attribute "data-shade"
#nu: Attribute data-shade not allowed on SVG element use at this point.
## example: #   <use id="use37" x="146" y="16" data-shade="-2" href="#shadeArea" xlink:href="#shadeArea"/>
# use svgcleaner
sed -ri 's/ <use([[:lower:][:digit:]=\" .]+) data-shade="-[12]"/ <use\1/g' $i

#W3C:  there is no attribute "data-name"
#nu: Attribute data-name not allowed on SVG element path at this point.
#example   <path class="cls-21" d="M456.28 3500.6h-4.34l-11.83 5.9v-5.9h-1.3l-1.94 8.4 19.41-.6v-1.3h-8.6l8.6-4.3z" data-name="upper left white-2"/>
sed -ri "s/ data-name=\"([-[:lower:][:digit:] ]*)\"/ id=\"\1\"/g" $i


#W3C: value of attribute "id" must be a single token
#nu:  Bad value  for attribute id on SVG element path: Not a valid XML 1.0 name.
## example:   <text id="lens _text-9" x="247.78" y="111.492" style="display:inline;fill:#000000;font-family:Arial;font-size:16px;line-height:100%;stroke-width:1px;text-align:center;text-anchor:middle" sodipodi:linespacing="100%" xml:space="preserve">
sed -ri "s/ <(g|path|text|rect) id=\"([-[:alnum:]íã:_\.]*)( |'|\(|\)|&|#|,|\/|\+)([-[:alnum:] \':_|\(|\)|&.,\/]+)\"/ <\1 id=\"\2_\4\"/g" $i #replaces (spaces and commas and /) with underlines
# do not use this line # sed -ri "s/ <(g|path) id=\"([[:digit:]]+)\"/ <\1 id=\"FIPS_\2\"/" $i #valid id names must not start with a number

#W3C (SVG1.1)  element "flowRoot" undefined
# Nu: SVG element flowRoot not allowed as child of SVG element g in this context. (Suppressing further errors from this subtree.)
## example: # <flowRoot id="flowRoot4648" transform="matrix(.755786 0 0 .755786 -20.0015 627.017)" style="fill:#000000;font-family:sans-serif;font-size:180px;letter-spacing:0px;line-height:125%;stroke-width:1px;word-spacing:0px" xml:space="preserve"><flowRegion id="flowRegion4650"><rect id="rect4652" x="280.822" y=".656929" width="291.934" height="239.406"/></flowRegion><flowPara id="flowPara4654"/></flowRoot>
sed -ri 's/<flowPara([-[:alnum:]\" \.\:\%\=\;#\(\)]*)\/>//g;s/<flowRoot([-[:alnum:]" \.:%=;]*)\/>//g' $i
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';%]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" ]*)>[[:space:]]*(<path[-[:alnum:]\.=\"\ \#]*\/>|<rect( id=\"[-[:alnum:]]*\"|) x=\"([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([[:lower:][:digit:]=\.\" \#:]+)\/>)[[:space:]]*<\/flowRegion>[[:space:]]*(|<flowPara([-[:alnum:]\.=\" \:\#;% ]*)>([[:space:] ]*)<\/flowPara>)[[:space:]]*<\/flowRoot>//g" $i ##delete flowRoot only containing spaces


#W3C there is no attribute "i:knockout"
#Nu  Adobe Illustrator 10.0 attribute knockout not allowed on SVG element path at this point.
# use scour without --keep-editor-data


#W3C there is no attribute "font-feature-settings"
#nu Attribute font-feature-settings not allowed on SVG element g at this point.
#svgo --enable=removeUnknownsAndDefaults

# SVG element ellipse is missing required attribute rx
#  required attribute "rx" not specified
# repair with inkscape
# not: (notscour/notcleaner/notsvgo) might contained d-data 

## == https://validator.w3.org/check ==

# W3C: there is no attribute "font-size"
sed -ri "s/<ellipse([-[:lower:][:digit:]\"\.= \(\)]*) font-size=\"8\"/<ellipse\1/g" $i

# W3C (SVG1.0): there is no attribute "solid-color"
## example #     <path transform="translate(-40.678 -59.61)" d="m273.1 413.76c-3.125-6.026 7.458-8.264 7.8282-17.23" color-rendering="auto" image-rendering="auto" shape-rendering="auto" solid-color="#000000" stroke-width=".945" style="isolation:auto;mix-blend-mode:normal"/>
sed -ri "s/<path([-[:lower:][:digit:]\"\.= \(\)]*) solid-color=\"#000000\"/<path\1/g" $i

#W3C (SVG1.1):  required attribute "type" not specified
#Repair https://phabricator.wikimedia.org/T68672 (solves librsvg-Bug)
#from svg2validsvg.sh
sed -ri "s/<style( id=\"[[:alnum:]]*\"|)>/<style type=\"text\/css\"\1>/" $i

#W3C (SVG1.1)  there is no attribute "href"
#W3C (SVG1.1) Error: required attribute "xlink:href" not specified
#CorelDraw-Problem (not very common)
#https://commons.wikimedia.org/wiki/File:IIIIER.svg
#https://commons.wikimedia.org/wiki/File:Eliandthethirteenthconfession_logo.svg
sed -i "s/ href=\"/  xmlns:xlink=\"http:\/\/www.w3.org\/1999\/xlink\" xlink:href=\"/g" $i


## == https://validator.nu/ ==

#nu Error: Attribute fill not allowed on SVG element image at this point.
# example https://commons.wikimedia.org/wiki/File:Epizentroa,_Hipozentroa_eta_failaren_diagrama.svg
sed -ri "s/<image([[:lower:][:digit:]\" =]*) fill=\"none\"([[:alnum:]\" =:;,+\/]*)>/<image\1\2>/g" $i


#nu Error:  Attribute clip-rule not allowed on SVG element linearGradient at this point.
#nu Error:  Attribute fill-rule not allowed on SVG element linearGradient at this point.
#nu Error: Attribute stroke-miterlimit not allowed on SVG element linearGradient at this point
#nu Error:  Attribute stroke-linecap not allowed on SVG element linearGradient at this point.
#nu Error: Attribute stroke-linejoin not allowed on SVG element linearGradient at this point.
#example: <linearGradient id="bo" x1="-302.7" x2="300.7" y1="99.7" y2="99.7" clip-rule="evenodd" fill-rule="evenodd" stroke-miterlimit="3.86" gradientUnits="userSpaceOnUse">
sed -ri "s/<linearGradient([-[:alnum:]=\". _]*)( clip-rule=\"evenodd\"| fill-rule=\"evenodd\"| stroke-miterlimit=\"3.[[:digit:]]*\"| stroke-linecap=\"round\"| stroke-linejoin=\"round\")( [-[:lower:][:upper:]=\" .]*)>/<linearGradient\1\3>/g" $i

##nu Error:  Attribute stroke-linecap not allowed on SVG element linearGradient at this point.
#sed -ri "s/ stroke-linecap=\"null\"//g"




echo $i finish



done

