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


##Remove W3C-invalid elements
#sed -ri "s/ text-align=\"(end|center)\"//g"  ${i}
#sed -i "s/ aria-label=\"[[:digit:]]\"//g;s/ stroke-linejoin=\"null\"//g;s/ stroke-linecap=\"null\"//g;s/ stroke-width=\"null\"//g" $i
#sed -i "s/ solid-color=\"#000000\"//g" $i #QGIS-Files (made file valid)
#
## <flowPara font-family="Liberation Sans" font-size="55.071px" style="line-height:125%"/>
#
## <flowPara id="flowPara10507" style="fill:url(#linearGradient11781)"/>
#
##remove empty flow Text in svg (everything else will be done by https://github.com/JoKalliauer/cleanupSVG/blob/master/Flow2TextByInkscape.sh )
##    <flowRoot id="flowRoot3750" style="fill:black;font-family:Linux Libertine;font-size:64;line-height:100%;text-align:center;text-anchor:middle;writing-mode:lr" xml:space="preserve"/>
#sed -ri 's/<flowPara([-[:alnum:]\" \.\:\%\=\;#\(\)]*)\/>//g;s/<flowRoot([-[:alnum:]" \.:%=;]*)\/>//g' $i
#sed -i 's/<flowSpan[-[:alnum:]=\":;\. ]*>[[:space:]]*<\/flowSpan>//g' $i
#sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion(\/|[[:alnum:]\"= ]*>[[:space:]]*<(path|rect) [-[:alnum:]\. \"\=:]*\/>[[:space:]]*<\/flowRegion)>[[:space:]]*(<flowDiv\/>|)[[:space:]]*<\/flowRoot>//g" $i #delete empty flowRoot
#
#


 
# if ! grep -qE "xmlns:xlink=" $i; then
#  sed -ri 's/<svg/<svg xmlns:xlink="http:\/\/www.w3.org\/1999\/xlink"/' $i
# fi


#Inkscape doesnt handle Adobe Ilustrator xmlns right
#sed -ri "s/=\"([amp38;\#\&\])+ns_flows;\"/=\"http:\/\/ns.adobe.com\/Flows\/1.0\/\"/g" $i 
#sed -ri "s/ xmlns:x=\"([amp38;\#\&\])+ns_extend;\"/ xmlns:x=\"http:\/\/ns.adobe.com\/Extensibility\/1.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
#sed -ri "s/=\"([amp38;\#\&\])+ns_ai;\"/=\"http:\/\/ns.adobe.com\/AdobeIllustrator\/10.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
#sed -ri "s/ xmlns:graph=\"([amp38;\#\&\])+ns_graphs;\"/ xmlns:graph=\"http:\/\/ns.adobe.com\/Graphs\/1.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
#sed -ri "s/=\"([amp38;\#\&\])+ns_vars;\"/=\"http:\/\/ns.adobe.com\/Variables\/1.0\/\"/g" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
#sed -ri "s/=\"([amp38;\#\&\])+ns_imrep;\"/=\"http:\/\/ns.adobe.com\/ImageReplacement\/1.0\/\"/g" $i #	<!ENTITY ns_imrep "http://ns.adobe.com/ImageReplacement/1.0/">
#sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_sfw;\"/ xmlns=\"http:\/\/ns.adobe.com\/SaveForWeb\/1.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
#sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_custom;\"/ xmlns=\"http:\/\/ns.adobe.com\/GenericCustomNamespace\/1.0\/\"/" $i
#	<!ENTITY ns_adobe_xpath "http://ns.adobe.com/XPath/1.0/">
#sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_svg;\"/ xmlns=\"http:\/\/www.w3.org\/2000\/svg\"/" $i
#sed -ri "s/ xmlns:xlink=\"([amp38;\#\&\])+ns_xlink;\"/ xmlns:xlink=\"http:\/\/www.w3.org\/1999\/xlink\"/" $i

#sed -i "s/<?xpacket begin='﻿' id='/<?xpacket begin='ZeichenEingefuegtVonKalliauer' id='/g" $i

#CorelDraw-Problem (not very common)
#sed -i "s/ href=\"#id/ xlink:href=\"#id/g" $i


#Remove CDATA by AdobeIllustrator
#sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\!\[CDATA\[([[:alnum:]=+\/\t\n[:space:]@:;\(\)\"\,\'\{\}\-])*\t\]\]>[[:space:]]*//g" $i #Remove CDATA
#sed -ri "s/<i:pgfRef xlink:href=\"#a([[:lower:]_]*)\"\/>//" $i #Remove AI-Elemtents for CDATA
#sed -i "s/<i:pgf id=\"a\"\/>//" $i #Remove AI-Elemtents for CDATA
#sed -ri -e ':a' -e 'N' -e "s/<i:pgf( ){1,2}id=\"a([[:lower:]_])*\">[[:space:]]*<\/i:pgf>//" $i #Remove AI-Elemtents for CDATA
#sed -i "s/ i:extraneous=\"self\"//" $i #Remove AI-Elemtents

#remove jpg im metadata
#sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<xapGImg:image>([[:alnum:][:space:]\/+])*={0,2}[[:space:]]*<\/xapGImg:image>//g" $i

# == make file valid ==

# font-weight="630"
#sed -i "s/ font-weight=\"630\"/ font-weight=\"bold\"/g" $i

#ArcMap-problems (made file valid, removes cbs= and gem=)
#sed -ri "s/<path d=\"m([[:digit:]hlmvz \.-]+)\" ([[:alnum:]\"= \.\(\)\#-]*)\" cbs=\"[[:digit:]GM]*\" gem=\"[[:alpha:]0 \.\(\)-]*\"\/>/<path d=\"m\1\" \2\"\/>/g" $i

##invalid id-names
#sed -ri "s/ <(g|path) id=\"([-[:alnum:]:_\.]*)( |'|\(|\)|&|#|,|\/)([-[:alnum:] \':_|\(|\)|&.,\/]+)\"/ <\1 id=\"\2_\4\"/" $i #replaces (spaces and commas and /) with underlines
#sed -ri "s/ <(g|path) id=\"([-[:alnum:]:_\.]+)( |'|\(|\)|&|#|,|\/)([-[:alnum:] \':_|\(|\)|&.,|\/]+)\"/ <\1 id=\"\2_\4\"/" $i #replaces spaces with underlines
#sed -ri "s/ <(g|path) id=\"([-[:alnum:]:_\.]+)( |'|\(|\)|&|#|,|\/)([-[:alnum:] \':_|\(|\)|&.,|\/]+)\"/ <\1 id=\"\2_\4\"/" $i #replaces spaces with underlines
#sed -ri "s/ <(g|path) id=\"([-[:alnum:]:_\.]+)( |'|\(|\)|&|#|,|\/)([-[:alnum:] \':_|\(|\)|&.,|\/]+)\"/ <\1 id=\"\2_\4\"/" $i #replaces spaces with underlines
## do not use this line # sed -ri "s/ <(g|path) id=\"([[:digit:]]+)\"/ <\1 id=\"FIPS_\2\"/" $i #valid id names must not start with a number
#
## there is no attribute "data-name" (SVG 2.0)
#sed -ri "s/<(svg|symbol|path|use|g)([[:alnum:]=\"\.\/ -:]*) data-name=\"[[:alnum:] ]+\"/<\1\2/" $i


##suggestions from https://en.wikipedia.org/wiki/Wikipedia:SVG_help
#sed -i "s/Sans embedded/DejaVu Sans/g" $i
#sed -ri "s/tspan x=\"([0-9]*) ([0-9 ]*)\"/tspan x=\"\1\"/g" $i
#sed -ri "s/<g style=\"stroke:none;fill:none\"><text>/<g style=\"stroke:none;fill:rgb(0,0,0)\"><text>/g" $i
#
### == Workaround for inkscape bug ==
# sed -ri "s/inkscape:version=\"0.(4[\. r[:digit:]]|91 r13725)+\"//g" $i # https://bugs.launchpad.net/inkscape/+bug/1763190
# sed -ri "s/sodipodi:role=\"line\"//g" $i # https://bugs.launchpad.net/inkscape/+bug/1763190
#
### == Repair after svgo ==
#
##svgo to cleaner
#sed -ri "s/font-family:&quot;([-[:alnum:] ]*)&quot;/font-family:\"\1\"/g" $i
#sed -ri "s/font-family:&apos;([-[:alnum:] ]*)&apos;/font-family:'\1'/g" $i
#
### == Workarounds for Librsvg ==
#
##Repair WARNING in <mask> with id=ay: Mask element found with maskUnits set. It will not be rendered properly by Wikimedia's SVG renderer. See https://phabricator.wikimedia.org/T55899 for details
#sed -ri "s/<mask([[:alnum:] =\"]*) maskUnits=\"userSpaceOnUse\"( id=\"[[:alnum:]_]+\"|)>/<mask\1\2>/g" $i
#
#
##Change spaces to , in stroke-dasharray (solves librsvg-Bug https://phabricator.wikimedia.org/T32033 )
#sed -ri 's/stroke-dasharray=\"([[:digit:]\.,]*)([[:digit:]\.]+) ([[:digit:]\., ]+)\"/stroke-dasharray=\"\1\2,\3\"/g' $i
#sed -ri 's/stroke-dasharray=\"([[:digit:]\., ]*)([[:digit:]\.]+) ([[:digit:]\.,]+)\"/stroke-dasharray=\"\1\2,\3\"/g' $i
#
##Change "'font name'" to 'font name'(solves librsvg-Bug) https://commons.wikimedia.org/wiki/File:T184369.svg
#sed -ri "s/font-family=\"'([-[:alnum:] ]*)'(|,[-[:lower:]]+)\"/font-family=\'\1\'/g" $i
#
## multiple x-koordinates https://phabricator.wikimedia.org/T35245
#sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:]])/<tspan x=\"\2\" \1 \5>\6<\/tspan><tspan x=\"\4\" \1 \5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
#sed -ri "s/<text([-[:alnum:]\.\"\#\ =\(\)]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =\,]*)>/<text x=\"\2\"\1\5>/g" $i # remove multipe x-koordinates in text (solves librsvg-Bug)
#sed -ri "s/<text([-[:alnum:]\.\"\#\ =\(\)]*) y=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =\,]*)>/<text y=\"\2\"\1\5>/g" $i # remove multipe y-koordinates in text (solves librsvg-Bug)
#
##Repair https://phabricator.wikimedia.org/T68672 (solves librsvg-Bug)
#sed -i "s/<style>/<style type=\"text\/css\">/" $i
#
##solved librsvg-Bug T193929 https://phabricator.wikimedia.org/T193929
#sed -i "s/ xlink:href=\"data:image\/jpg;base64,/ xlink:href=\"data:image\/jpeg;base64,/g" $i
#sed -i "s/ xlink:href=\"data:;base64,\/9j\/4AAQSkZJRgABAgAAZABkAAD\/7AARRHVja3kAAQAEAAAAHgAA/ xlink:href=\"data:image\/jpeg;base64,\/9j\/4AAQSkZJRgABAgAAZABkAAD\/7AARRHVja3kAAQAEAAAAHgAA/" $i
#sed -ri "s/ xlink:href=\"data:;base64,( |)iVBORw0KGgoAAAANSUhEUgAA/ xlink:href=\"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAA/" $i
#
##solved librsvg-Bug T194192 https://phabricator.wikimedia.org/T194192
##<svg font-family="ScriptS" font-size="5" viewBox="0,0,128,128"
#sed -ri "s/<svg([-[:alnum:]=\" ]*) viewBox=\"0,0,([[:digit:]\.]*),([[:digit:]\.]*)\"/<svg\1 viewBox=\"0 0 \2 \3\"/g" $i
#
##librsvgbug https://phabricator.wikimedia.org/phab:T207506 (<code>font-weight="normal"</code> ignored)
#sed -ri "s/font-weight=\"normal\"/font-weight=\"400\"/g" $i




## == https://validator.w3.org/check and https://validator.nu/ ==
# W3C: there is no attribute "line-height"
# Nu:   Attribute text-align not allowed on SVG element text at this point.
## example     <text id="text8220" x="126.62" y="85.62" font-size="16.25" style="font-family:'Liberation Sans';font-size:16.25px;letter-spacing:0;line-height:125%;text-align:center;text-anchor:middle;word-spacing:0" line-height="125%" sodipodi:linespacing="125%"><tspan id="tspan8222" x="126.62" y="85.62">1</tspan></text>
sed -ri "s/<text([-[:alnum:]=\.\" \(\)\':;%]*) line-height=\"125%\"/<text\1/g" $i

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
  
#W3C: element "rdf:RDF" undefined
#Nu: Warning: This validator does not validate RDF. RDF subtrees go unchecked.
# use scour/svgcleaner/svgo or https://de.wikipedia.org/wiki/Benutzer:Marsupilami/Inkscape-FAQ#Wie_erstelle_ich_eine_Datei_die_dem_Standard_SVG_1.1_entspricht?

#W3C: Error: there is no attribute "sodipodi:version"
#W3C: Error: element "sodipodi:namedview" undefined
#W3C: Error: element "inkscape:perspective" undefined
#W3C: Error:  there is no attribute "inkscape:collect"
#W3C: Error: there is no attribute "sodipodi:cx"
#W3C: Error: there is no attribute "inkscape:label"
#W3C: Error:  there is no attribute "sodipodi:nodetypes"
#Nu: Warning: This validator does not validate Inkscape extensions properly. Inkscape-specific errors may go unnoticed.
# use scour/svgcleaner --remove-nonsvg-attributes yes --remove-nonsvg-elements yes/svgo

#W3C: Error:  there is no attribute "enable-background"
#Nu: Error: Attribute enable-background not allowed on SVG element path at this point.
#use svgcleaner --remove-needless-attributes yes



## == https://validator.w3.org/check ==

# W3C: there is no attribute "font-size"
# example  <ellipse id="ellipse5986" transform="matrix(1.59508 0 0 1.57553 205.96 -1234.18)" cx="5.67" cy="836.22" rx="5.67" ry="5.67" font-size="8" stroke="#000" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.2"/>
sed -ri "s/<ellipse([-[:lower:][:digit:]\"\.= \(\)]*) font-size=\"8\"/<ellipse\1/g" $i

# W3C (SVG1.0): there is no attribute "solid-color"
## example #     <path transform="translate(-40.678 -59.61)" d="m273.1 413.76c-3.125-6.026 7.458-8.264 7.8282-17.23" color-rendering="auto" image-rendering="auto" shape-rendering="auto" solid-color="#000000" stroke-width=".945" style="isolation:auto;mix-blend-mode:normal"/>
sed -ri "s/<path([-[:lower:][:digit:]\"\.= \(\)]*) solid-color=\"#000000\"/<path\1/g" $i



## == https://validator.nu/ ==

# Nu:  Bad value  for attribute id on SVG element text: Not a valid XML 1.0 name.
## example:   <text id="lens _text-9" x="247.78" y="111.492" style="display:inline;fill:#000000;font-family:Arial;font-size:16px;line-height:100%;stroke-width:1px;text-align:center;text-anchor:middle" sodipodi:linespacing="100%" xml:space="preserve">
sed -ri "s/ <(g|path|text) id=\"([-[:alnum:]:_\.]*)( |'|\(|\)|&|#|,|\/)([-[:alnum:] \':_|\(|\)|&.,\/]+)\"/ <\1 id=\"\2_\4\"/g" $i #replaces (spaces and commas and /) with underlines

# Nu: SVG element flowRoot not allowed as child of SVG element g in this context. (Suppressing further errors from this subtree.)
## example: # <flowRoot xml:space="preserve" id="flowRoot6632" style="font-style:normal;font-weight:normal;line-height:0.01%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" transform="translate(-124.262,-11.219988)"><flowRegion id="flowRegion6634"><rect id="rect6636" width="13.498034" height="74.239189" x="-868.93591" y="1216.3513" /></flowRegion><flowPara id="flowPara6638" style="font-size:40px;line-height:1.25"> </flowPara></flowRoot>
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" ]*)>[[:space:]]*(<path[-[:alnum:]\.=\"\ \#]*\/>|<rect( id=\"[-[:alnum:]]*\"|) x=\"([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([[:lower:][:digit:]=\.\" \#:]+)\/>)[[:space:]]*<\/flowRegion>[[:space:]]*(|<flowPara([-[:alnum:]\.=\" \:\#;% ]*)>([[:space:] ]*)<\/flowPara>)[[:space:]]*<\/flowRoot>//g" $i ##delete flowRoot only containing spaces



echo $i finish



done

