#!/bin/bash
#solves librsvg-Bug (Workarounds)
# Input $1 ... File from Commons (downloaded, repaired and overwritten automatically)

# export ScourScour=YES ; export SVGCleaner=YES ; export EinzeilTags=YES; export validValid=YES;
# export ScourScour=NO  ; export SVGCleaner=NO  ; export EinzeilTags=NO ; export validValid=NO ;

## == Credit ==
#Author: Johannes Kalliauer (JoKalliauer)
#created: 2019-02-20
#published: https://github.com/JoKalliauer/cleanupSVG and https://github.com/JoKalliauer/convert

## == Last changes ==
#2019-04-26 20h37 by JoKalliauer included SVGCleaner, remove default/empty/useless metadata/sodipodi:namedview,  href to xlink:href
#2019-04-27 12h12 by JoKalliauer included scour, small changes for metadataremove


## == Programm ==


#---- 

export i=$1
export i2=tmp.svg
export i3=Output.svg

#~/.bash_profile

T35245tspan=YES

if [ -z ${SVGCleaner+x} ]; then
 SVGCleaner=YES
fi
if [ -z ${EinzeilTags+x} ]; then
 EinzeilTags=YES
fi
if [ -z ${ScourScour+x} ]; then
 echo set scour to yes
 ScourScour=YES
fi
if [ -z ${validValid+x} ]; then
 validValid=NO
fi
if [ -z ${kerningKerning+x} ] || [ -z "$kerningKerning" ]; then
 kerningKerning=NO
fi

if [ $HOSTNAME = LAPTOP-K1FUMMIP ]; then
 PC=local
elif [ $HOSTNAME = jkalliau-Z87M-D3H ]; then
 PC=local
elif [ $HOSTNAME = tools-sgebastion-07 ]; then
 PC=WikiMedia
elif [ $HOSTNAME = DESKTOP-7VKND0M ]; then
 PC=local
elif [[ $HOSTNAME =  tools-sgewebgrid-lighttpd-* ]]; then
 PC=WikiMedia
elif [[ $HOSTNAME =  localhost.localdomain ]]; then
 PC=local
else
 echo did not recognice HOSTNAME $HOSTNAME
fi

chmod u+r *
chmod u+rx *.sh

if [ -z "$1" ]
  then
    echo "No inputfile supplied"
	exit
fi

if [ $PC = local ]; then
 rm -f $1
 wget -q https://commons.wikimedia.org/wiki/Special:FilePath/$i -O $i
 export ScourJK="python3 -m scour.scour"
else
 if [ $HOSTNAME = tools-sgebastion-07 ]; then
  #this is needed to run bot
  rm -f $1
  rm -f *.svg
  wget -q https://commons.wikimedia.org/wiki/Special:FilePath/$i -O $i 
  export ScourJK="python3 -m scour.scour"
  
 else
  echo did not recognice HOSTNAME $HOSTNAME
 fi
fi
export PATH=/data/project/svgworkaroundbot/prgm2/pythonJK/PythonIn/bin/:/data/project/svgworkaroundbot/SVGWorkaroundBot/cleanupSVG-master/:/data/project/svgworkaroundbot/prgm/svgcleaner/:$PATH:~/bin/

# ---- Begin ----


if [ $EinzeilTags = 'YES' ]; then
  sed -i "s/\r/ /g" $i #remove carriage return (DOS,MAC)
  sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/\n[[:space:]]+/ /g" $i #reduce to one space
  #sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/[[:space:]\r\n]+/ /g" $i #no need for that
  sed -ri 's/[[:space:]]*<(g|path|svg|flowRoot|defs|clipPath|radialGradient|linearGradient|filter|mask|pattern|text|metadata|!--|image|inkscape:perspective) /\n<\1 /g' $i
fi

#remove empty flow Text in svg (first update svg2validsvg.sh)
#remove empty flow Text in svg (everything else will be done by https://github.com/JoKalliauer/cleanupSVG/blob/master/Flow2TextByInkscape.sh )
sed -ri "s/<flowPara([-[:alnum:]\"\' \.\:\%\=\;\,#\(\)]*)\/>//g;s/<flowRoot([-[:alnum:]\" \.:%=;]*)\/>//g" $i
sed -i 's/<flowSpan[-[:alnum:]=\":;\. ]*>[[:space:]]*<\/flowSpan>//g' $i
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion(\/|[[:alnum:]\"= ]*>[[:space:]]*<(path|rect) [-[:alnum:]\. \"\=:]*\/>[[:space:]]*<\/flowRegion)>[[:space:]]*(<flowDiv\/>|)[[:space:]]*<\/flowRoot>//g" $i #delete empty flowRoot
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" ]*)>[[:space:]]*(<path[-[:alnum:]\.=\"\ \#]*\/>|<rect( id=\"[-[:alnum:]]*\"|) x=\"([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([[:lower:][:digit:]=\.\" \#:]+)\/>)[[:space:]]*<\/flowRegion>[[:space:]]*(|<flowPara([-[:alnum:]\.=\" \:\#;% ]*)>([[:space:] ]*)<\/flowPara>)[[:space:]]*<\/flowRoot>//g" $i ##delete flowRoot only containing spaces

sed -ri "s/inkscape:version=\"0.(4[\. r[:digit:]]+|91 r13725)\"//g" $i # https://bugs.launchpad.net/inkscape/+bug/1763190

 sed -i "s/ inkscape:connector-curvature=\"0\"//g" $i #https://commons.wikimedia.org/wiki/File:Royal_Monogram_of_Princess_Adityadhornkitikhun.svg


if [ $validValid = 'YES' ]; then
 export scour
 echo runScourScour,JK $ScourJK, YN $ScourScour, i $i ,ii $i2
 #rm tmp.svg
 if [ $PC = WikiMedia ]; then
  /data/project/svgworkaroundbot/prgm2/pythonJK/PythonIn/bin/python3.7 -m scour.scour -i $i -o $i2 --keep-unreferenced-defs --remove-descriptions --strip-xml-space  --set-precision=6 --indent=space --nindent=1 --renderer-workaround --set-c-precision=6 --protect-ids-noninkscape  --disable-simplify-colors  --keep-editor-data 
 else
  python3 -m scour.scour -i $i -o $i2 --keep-unreferenced-defs --remove-descriptions --strip-xml-space  --set-precision=6 --indent=space --nindent=1 --renderer-workaround --set-c-precision=6 --protect-ids-noninkscape  --disable-simplify-colors  --keep-editor-data 
 fi

 python3 ./FFlow2TextBySed.py $i2 $i3
 rm $i
 mv $i3 $i
else
 if [ $ScourScour = 'YES' ]; then
  export scour
  echo runScourScour,JK $ScourJK, YN $ScourScour, i $i ,ii $i2
  #rm tmp.svg
  if [ $PC = WikiMedia ]; then
   /data/project/svgworkaroundbot/prgm2/pythonJK/PythonIn/bin/python3.7 -m scour.scour -i $i -o $i2 --keep-unreferenced-defs --remove-descriptions --strip-xml-space  --set-precision=6 --indent=space --nindent=1 --renderer-workaround --set-c-precision=6 --protect-ids-noninkscape  --disable-simplify-colors  --keep-editor-data
  else
   python3 -m scour.scour -i $i -o $i2 --keep-unreferenced-defs --remove-descriptions --strip-xml-space  --set-precision=6 --indent=space --nindent=1 --renderer-workaround --set-c-precision=6 --protect-ids-noninkscape  --disable-simplify-colors  --keep-editor-data 
  fi

  python3 ./FFlow2TextBySed.py $i2 $i3
  rm $i
  mv $i3 $i
 else
  echo no ScourScour $ScourScour
 fi
fi


   ## invalid file

#W3C (SVG1.1)  there is no attribute "href"
#W3C (SVG1.1) Error: required attribute "xlink:href" not specified
#CorelDraw-Problem (not very common)
#https://commons.wikimedia.org/wiki/File:IIIIER.svg
#https://commons.wikimedia.org/wiki/File:Eliandthethirteenthconfession_logo.svg
sed -i "s/ href=\"/  xmlns:xlink=\"http:\/\/www.w3.org\/1999\/xlink\" xlink:href=\"/g" $i

if [ $SVGCleaner = 'YES' ]; then
 echo runsvgcleaner $SVGCleaner
 svgcleaner $i $i2 --allow-bigger-file --indent 1 --resolve-use no --apply-transform-to-gradients yes --apply-transform-to-shapes yes --convert-shapes yes --group-by-style no --join-arcto-flags no --join-style-attributes no --merge-gradients yes --regroup-gradient-stops yes --remove-comments no --remove-declarations no --remove-default-attributes yes --remove-desc yes --remove-dupl-cmd-in-paths yes --remove-dupl-fegaussianblur yes --remove-dupl-lineargradient yes --remove-dupl-radialgradient yes --remove-gradient-attributes yes --remove-invalid-stops yes --remove-invisible-elements no --remove-metadata no --remove-needless-attributes yes --remove-nonsvg-attributes no --remove-nonsvg-elements no --remove-text-attributes no --remove-title no --remove-unreferenced-ids no --remove-unresolved-classes yes --remove-unused-coordinates yes --remove-unused-defs yes --remove-version yes --remove-xmlns-xlink-attribute yes --simplify-transforms yes --trim-colors yes --trim-ids no --trim-paths yes --ungroup-defs yes --ungroup-groups no --use-implicit-cmds yes --list-separator comma --paths-to-relative yes --remove-unused-segments yes --convert-segments yes --apply-transform-to-paths no --coordinates-precision 2 --paths-coordinates-precision 5 --properties-precision 3 --transforms-precision 7 #--copy-on-error
 rm $i
 mv $i2 $i
else 
 echo no SVGCleaner $SVGCleaner
fi
if [ $validValid = 'YES' ]; then
 svgcleaner $i $i2 --allow-bigger-file --indent 1 --remove-nonsvg-attributes yes --remove-nonsvg-elements yes --remove-version yes --remove-text-attributes yes --remove-needless-attributes yes --resolve-use no --apply-transform-to-gradients yes --apply-transform-to-shapes yes --convert-shapes yes --group-by-style no --join-arcto-flags no --join-style-attributes no --merge-gradients yes --regroup-gradient-stops yes --remove-comments yes --remove-declarations no --remove-default-attributes yes --remove-desc yes --remove-dupl-cmd-in-paths yes --remove-dupl-fegaussianblur yes --remove-dupl-lineargradient yes --remove-dupl-radialgradient yes --remove-gradient-attributes yes --remove-invalid-stops yes --remove-invisible-elements yes --remove-metadata no --remove-title yes --remove-unreferenced-ids yes --remove-unresolved-classes yes --remove-unused-coordinates yes --remove-unused-defs yes --remove-xmlns-xlink-attribute yes --simplify-transforms yes --trim-colors yes --trim-ids yes --trim-paths yes --ungroup-defs yes --ungroup-groups yes --use-implicit-cmds yes --list-separator comma --paths-to-relative yes --remove-unused-segments yes --convert-segments yes --apply-transform-to-paths no --coordinates-precision 2 --paths-coordinates-precision 5 --properties-precision 3 --transforms-precision 5
 mv $i2 $i
fi

#remove useless metadata
sed -i "s/<metadata id=\"metadata8\">  <rdf:RDF>  <cc:Work rdf:about=\"\">  <dc:format>image\/svg+xml<\/dc:format>  <dc:type rdf:resource=\"http:\/\/purl.org\/dc\/dcmitype\/StillImage\"\/>  <dc:title\/>  <\/cc:Work>  <\/rdf:RDF>  <\/metadata>//" $i


#Remove CDATA by AdobeIllustrator
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\!\[CDATA\[([[:alnum:]=+\/\t\n[:space:]@:;\(\)\"\,\'\{\}\-])*\t\]\]>[[:space:]]*//g" $i #Remove CDATA
sed -ri -e ':a' -e 'N' -e "s/<i:pgf[[:lower:] =\"_]*>[[:space:][:alnum:]\/=\+]*<\/i:pgf>//" $i #Remove AI-Elemtents for CDATA

#remove jpg im metadata
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<xapGImg:image>([[:alnum:][:space:]\/+])*={0,2}[[:space:]]*<\/xapGImg:image>//g" $i

## == unsave uploads
#https://commons.wikimedia.org/wiki/Commons:Help_desk#Found_unsafe_CSS_in_the_style_element_of_uploaded_SVG_file
sed -i "s/src: url(\"data:font\/woff;charset=utf-8;base64,data:application\/x-font-ttf;base64,AAEAAAAQAQAABAAAR[[:alnum:]+\/]*\");//" $i

## == Workarounds for Librsvg ==

#Repair WARNING in <mask> with id=ay: Mask element found with maskUnits set. It will not be rendered properly by Wikimedia's SVG renderer. See https://phabricator.wikimedia.org/T55899 for details
#copied from svg2validsvg
sed -ri "s/<mask([-[:alnum:]_ =\".]*) maskUnits=\"userSpaceOnUse\"([[:alnum:]=_\". ]*)>/<mask\1\2>/g" $i

#Change spaces to , in stroke-dasharray (solves librsvg-Bug https://phabricator.wikimedia.org/T32033 )
sed -ri 's/stroke-dasharray=\"([[:digit:]\.,]*)([[:digit:]\.]+) ([[:digit:]\., ]+)\"/stroke-dasharray=\"\1\2,\3\"/g' $i
sed -ri 's/stroke-dasharray=\"([[:digit:]\., ]*)([[:digit:]\.]+) ([[:digit:]\.,]+)\"/stroke-dasharray=\"\1\2,\3\"/g' $i

#Change "'font name'" to 'font name'(solves librsvg-Bug) https://commons.wikimedia.org/wiki/File:T184369.svg
sed -ri "s/font-family=\"'([-[:alnum:] ]*)'(|,[-[:lower:]]+)\"/font-family=\'\1\'/g" $i

# multiple x-koordinates https://phabricator.wikimedia.org/T35245
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:]])/<tspan x=\"\2\" \1 \5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # resolves multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<text([-[:alnum:]\.\"\#\ =\(\)]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =\,]*)>/<text x=\"\2\"\1\5>/g" $i # remove multipe x-koordinates in text (solves librsvg-Bug)
sed -ri "s/<text([-[:alnum:]\.\"\#\ =\(\)]*) y=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =\,]*)>/<text y=\"\2\"\1\5>/g" $i # remove multipe y-koordinates in text (solves librsvg-Bug)

#Repair https://phabricator.wikimedia.org/T68672 (solves librsvg-Bug)
#from svg2validsvg
sed -ri "s/<style( id=\"[[:alnum:]]*\"|)>/<style type=\"text\/css\"\1>/" $i

#solved librsvg-Bug T193929 https://phabricator.wikimedia.org/T193929
sed -i "s/ xlink:href=\"data:image\/jpg;base64,/ xlink:href=\"data:image\/jpeg;base64,/g" $i
sed -i "s/ xlink:href=\"data:;base64,\/9j\/4AAQSkZJRgABAgAAZABkAAD\/7AARRHVja3kAAQAEAAAAHgAA/ xlink:href=\"data:image\/jpeg;base64,\/9j\/4AAQSkZJRgABAgAAZABkAAD\/7AARRHVja3kAAQAEAAAAHgAA/" $i
sed -ri "s/ xlink:href=\"data:;base64,( |)iVBORw0KGgoAAAANSUhEUgAA/ xlink:href=\"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAA/" $i
sed -ri "s/ xlink:href=\"data:image\/png;base64,( |)\/9j\/4AAQSkZJRgABAQAAAQABAAD/ xlink:href=\"data:image\/jpeg;base64,\/9j\/4AAQSkZJRgABAQAAAQABAAD/" $i #png->jpeg

#solved librsvg-Bug T194192 https://phabricator.wikimedia.org/T194192
sed -ri "s/<svg([-[:alnum:]=\" ]*) viewBox=\"0,0,([[:digit:]\.]*),([[:digit:]\.]*)\"/<svg\1 viewBox=\"0 0 \2 \3\"/g" $i

#librsvgbug https://phabricator.wikimedia.org/phab:T207506 (<code>font-weight="normal"</code> ignored)
sed -ri "s/font-weight=\"normal\"/font-weight=\"400\"/g" $i

if [ $T35245tspan = 'YES' ]; then
# remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([-[:alnum:] \'\+=\.\%\)→\/,:√])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i
fi

## useless

  #remove useless/empty metadata
#W3C: element "rdf:RDF" undefined
#Nu: Warning: This validator does not validate RDF. RDF subtrees go unchecked.
# use scour/svgcleaner/svgo or https://de.wikipedia.org/wiki/Benutzer:Marsupilami/Inkscape-FAQ#Wie_erstelle_ich_eine_Datei_die_dem_Standard_SVG_1.1_entspricht?
#copied form validbySed
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/[[:space:]\r\n]*<rdf:RDF>[[:space:]\r\n]*<cc:Work( rdf:about=\"\"|)>[[:space:]\r\n]*<dc:format>image\/svg\+xml<\/dc:format>[[:space:]\r\n]*<dc:type rdf:resource=\"http:\/\/purl.org\/dc\/dcmitype\/StillImage\"\/>([[:space:]\r\n]*<dc:title\/>|)[[:space:]\r\n]*<\/cc:Work>[[:space:]\r\n]*<\/rdf:RDF>//" $i
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<metadata id=\"metadata[[:digit:]]*\">[[:space:]\r\n]*<\/metadata>//" $i
   

#W3C: Error: there is no attribute "sodipodi:version"
#W3C: Error: element "sodipodi:namedview" undefined
#W3C: Error: element "inkscape:perspective" undefined
#W3C: Error:  there is no attribute "inkscape:collect"
#W3C: Error: there is no attribute "sodipodi:cx"
#W3C: Error: there is no attribute "inkscape:label"
#W3C: Error:  there is no attribute "sodipodi:nodetypes"
#Nu: Warning: This validator does not validate Inkscape extensions properly. Inkscape-specific errors may go unnoticed.
# use scour/svgcleaner --remove-nonsvg-attributes yes --remove-nonsvg-elements yes/svgo
   sed -i "s/<sodipodi:namedview id=\"namedview[[:digit:]]*\" bordercolor=\"#666666\" borderopacity=\"1\" gridtolerance=\"10\" guidetolerance=\"10\" inkscape:current-layer=\"svg[[:digit:]]*\" inkscape:cx=\"[[:digit:].]*\" inkscape:cy=\"[-[:digit:].]*\" inkscape:pageopacity=\"0\" inkscape:pageshadow=\"2\" inkscape:window-height=\"480\" inkscape:window-maximized=\"0\" inkscape:window-width=\"640\" inkscape:window-x=\"0\" inkscape:window-y=\"0\" inkscape:zoom=\"0.[[:digit:]]*\" objecttolerance=\"10\" pagecolor=\"#ffffff\" showgrid=\"false\"\/>//" $i

   ## invalid file
   
## fonts
sed -ri 's/ font-family=\"(Times New Roman)\"/ font-family=\"Liberation Serif,\1\"/g' $i #as automatic

if [ $kerningKerning = 'YES' ]; then
# ./T36947kerning.sh
	#put viewBox at the beginning (otherwise I will have a variable to less)
	sed -ri 's/<svg([-[:alnum:]=\" \.\/:\,\(\)_#]+) viewBox="([-[:digit:] \.]+)"([-[:alnum:]=\" \.\/:\,\(\);#]*)>/<svg viewBox="\2"\1\3>/' $i
	sed -ri 's/\r/\n/g' $i
	
    #Define file as a variable
    export h=$(sed -r 's/<svg viewBox="([-[:digit:]]+) ([-[:digit:]]+) ([[:digit:]]+)\.([[:digit:]])([[:digit:]]*) ([[:digit:]]+)\.([[:digit:]])([[:digit:]]*)"([-[:alnum:]=\" \.\/:\,\(\)_;]+)>/<svg viewBox="\1 \2 \3\4.\50 \6\7.\80"\9><g transform="scale(10)">/' $i)
    
    #Reading out the relevant line
    export j=$(ls -l|grep -E "viewBox=\"[-[:digit:].]{1,8} [-[:digit:].]{1,8} [[:digit:].]{2,11} [[:digit:].]{2,11}" $i)
    
    #Insert a special character to define the point of splitting
    export l=$(echo $j | sed -e "s/viewBox=\"/>/g" )
    
    #split at this special character and take the part afterwards
    export m=$(echo $l | cut -f2 -d">")
    
    #Multiply the four numbers by a factor of 10
    export n=$(echo $m | awk  '{printf "%f %f %f %f\n",$1*10,$2*10,$3*10,$4*10}')
    
    #Replace the old four numbers with the new four numbers
    sed -ri "s/<svg([-[:alnum:]=\" \.\/:;\,#]*) viewBox=\"[-[:digit:]\.]+ [-[:digit:]\.]+ [[:digit:]\.]+ [[:digit:]\.]+\"([-[:alnum:]=\" \.\/:\,#\(\)_;]+)>/<svg\1 viewBox=\"$n\"\2>\n<g transform=\"scale(10)\">/" $i
 #----

  sed -ri 's/<\/svg>/<\/g>\n<\/svg>/' $i
fi

#fontReplace
sed -ri 's/ font-family=\"(Arial|MyriadPro|Myriad Pro)/ font-family=\"Liberation Sans,\1/g' $i #as automatic

# ---- END ----

#cp -f $i $2

export uploadcomment="WorkaroundForLibrsvgBugs Scour$ScourScour SVGCleaner$SVGCleaner [[User:SVGWorkaroundBot/source]], solves bugs such as: [[phab:T55899]], [[phab:T68672]], [[phab:T43424]], [[phab:T193929]], [[phab:T35245]] reduce invalid-Errors, convert flowRoot to SVG1.1-text, please see file-description-page on commons for the actual bug"

if [ $HOSTNAME = DESKTOP-7VKND0M ]; then
 echo "$uploadcomment"
 echo do upload manually
else
 if [ $PC = WikiMedia ]; then
  #echo no upload
  echo
  echo python3 /data/project/shared/pywikipedia/core/scripts/upload.py $i -keep -ignorewarn -noverify -descfile "$uploadcomment"
  echo
  python3 /data/project/shared/pywikipedia/core/scripts/upload.py $i -keep -ignorewarn -noverify -descfile "$uploadcomment"
  #rm $i
 else
  echo did not recognice HOSTNAME $HOSTNAME
 fi
fi

