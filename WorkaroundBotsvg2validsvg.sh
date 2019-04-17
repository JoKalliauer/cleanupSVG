#!/bin/bash

#Author: Johannes Kalliauer (JoKalliauer)
#created: 2019-02-20

# $1 ... input (f.e. Buggy.svg)
# $2 ... output (f.e. Repaired.svg)
# $3 ... SVGCleaner (YES or NO)

rm -f $1

export i=$1

#----

~/.bash_profile

T35245tspan=YES
EinzeilTags=YES
#SVGCleaner=YES

if [ -z ${SVGCleaner+x} ]; then
 SVGCleaner=YES
fi

wget -q https://commons.wikimedia.org/wiki/Special:FilePath/$i -O $i

if [ $SVGCleaner = '' ]; then
 SVGCleaner=YES
fi

export PATH=/data/project/svgworkaroundbot/SVGWorkaroundBot/cleanupSVG-master/:/data/project/svgworkaroundbot/prgm/svgcleaner/:$PATH

  sed -i "s/\r/ /g" $i #remove carriage return (DOS,MAC)
  sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/\n[[:space:]]+/ /g" $i #reduce to one space
  #sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/[[:space:]\r\n]+/ /g" $i #no need for that
  sed -ri 's/[[:space:]]*<(g|path|svg|flowRoot|defs|clipPath|radialGradient|linearGradient|filter|mask|pattern|text|metadata) /\r\n<\1 /g' $i


#remove empty flow Text in svg (first update svg2validsvg.sh)
#remove empty flow Text in svg (everything else will be done by https://github.com/JoKalliauer/cleanupSVG/blob/master/Flow2TextByInkscape.sh )
sed -ri 's/<flowPara([-[:alnum:]\" \.\:\%\=\;#\(\)]*)\/>//g;s/<flowRoot([-[:alnum:]" \.:%=;]*)\/>//g' $i
sed -i 's/<flowSpan[-[:alnum:]=\":;\. ]*>[[:space:]]*<\/flowSpan>//g' $i
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion(\/|[[:alnum:]\"= ]*>[[:space:]]*<(path|rect) [-[:alnum:]\. \"\=:]*\/>[[:space:]]*<\/flowRegion)>[[:space:]]*(<flowDiv\/>|)[[:space:]]*<\/flowRoot>//g" $i #delete empty flowRoot
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" ]*)>[[:space:]]*(<path[-[:alnum:]\.=\"\ \#]*\/>|<rect( id=\"[-[:alnum:]]*\"|) x=\"([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([[:lower:][:digit:]=\.\" \#:]+)\/>)[[:space:]]*<\/flowRegion>[[:space:]]*(|<flowPara([-[:alnum:]\.=\" \:\#;% ]*)>([[:space:] ]*)<\/flowPara>)[[:space:]]*<\/flowRoot>//g" $i ##delete flowRoot only containing spaces

sed -ri "s/inkscape:version=\"0.(4[\. r[:digit:]]+|91 r13725)\"//g" $i # https://bugs.launchpad.net/inkscape/+bug/1763190

 #copied from FFlow2TextBySed.sh https://github.com/JoKalliauer/cleanupSVG/blob/master/FFlow2TextBySed.sh
 sed -ri "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" #;\.%\',]*)>[[:space:]]*<rect([-[:lower:][:digit:]\"= \.:;]*) x=\"([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([-[:alnum:]=\.\" \#:;\',]*)\/>[[:space:]]*<\/flowRegion>[[:space:]]*<flowPara([-[:alnum:]\.=\" \:\#;\%]*)>([-−[:alnum:] \{\}\(\)\+\ \ \.\?\']+)<\/flowPara>[[:space:]]*<\/flowRoot>/<text x=\"\4\" y=\"\5\"\1><tspan x=\"\4\" y=\"\5\"\7>\8<\/tspan><\/text>/g" $i
 


if [ $SVGCleaner = 'YES' ]; then
 svgcleaner $i tmp.svg --allow-bigger-file --indent 1 --resolve-use no --apply-transform-to-gradients yes --apply-transform-to-shapes yes --convert-shapes yes --group-by-style no --join-arcto-flags no --join-style-attributes no --merge-gradients yes --regroup-gradient-stops yes --remove-comments no --remove-declarations no --remove-default-attributes yes --remove-desc yes --remove-dupl-cmd-in-paths yes --remove-dupl-fegaussianblur yes --remove-dupl-lineargradient yes --remove-dupl-radialgradient yes --remove-gradient-attributes yes --remove-invalid-stops yes --remove-invisible-elements no --remove-metadata no --remove-needless-attributes yes --remove-nonsvg-attributes no --remove-nonsvg-elements no --remove-text-attributes no --remove-title no --remove-unreferenced-ids no --remove-unresolved-classes yes --remove-unused-coordinates yes --remove-unused-defs yes --remove-version yes --remove-xmlns-xlink-attribute yes --simplify-transforms yes --trim-colors yes --trim-ids no --trim-paths yes --ungroup-defs yes --ungroup-groups no --use-implicit-cmds yes --list-separator comma --paths-to-relative yes --remove-unused-segments yes --convert-segments yes --apply-transform-to-paths no --coordinates-precision 2 --paths-coordinates-precision 5 --properties-precision 3 --transforms-precision 7 --copy-on-error
 cp -f tmp.svg $i
fi

#remove useless metadata
sed -i "s/<metadata id=\"metadata8\">  <rdf:RDF>  <cc:Work rdf:about=\"\">  <dc:format>image\/svg+xml<\/dc:format>  <dc:type rdf:resource=\"http:\/\/purl.org\/dc\/dcmitype\/StillImage\"\/>  <dc:title\/>  <\/cc:Work>  <\/rdf:RDF>  <\/metadata>//" $i



#Remove CDATA by AdobeIllustrator
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\!\[CDATA\[([[:alnum:]=+\/\t\n[:space:]@:;\(\)\"\,\'\{\}\-])*\t\]\]>[[:space:]]*//g" $i #Remove CDATA

#remove jpg im metadata
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<xapGImg:image>([[:alnum:][:space:]\/+])*={0,2}[[:space:]]*<\/xapGImg:image>//g" $i


## == Workarounds for Librsvg ==

#Repair WARNING in <mask> with id=ay: Mask element found with maskUnits set. It will not be rendered properly by Wikimedia's SVG renderer. See https://phabricator.wikimedia.org/T55899 for details
sed -ri "s/<mask([[:alnum:] =\"]*) maskUnits=\"userSpaceOnUse\"( id=\"[[:alnum:]_]+\"|)>/<mask\1\2>/g" $i

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
sed -i "s/<style>/<style type=\"text\/css\">/" $i

#solved librsvg-Bug T193929 https://phabricator.wikimedia.org/T193929
sed -i "s/ xlink:href=\"data:image\/jpg;base64,/ xlink:href=\"data:image\/jpeg;base64,/g" $i
sed -i "s/ xlink:href=\"data:;base64,\/9j\/4AAQSkZJRgABAgAAZABkAAD\/7AARRHVja3kAAQAEAAAAHgAA/ xlink:href=\"data:image\/jpeg;base64,\/9j\/4AAQSkZJRgABAgAAZABkAAD\/7AARRHVja3kAAQAEAAAAHgAA/" $i
sed -ri "s/ xlink:href=\"data:;base64,( |)iVBORw0KGgoAAAANSUhEUgAA/ xlink:href=\"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAA/" $i

#solved librsvg-Bug T194192 https://phabricator.wikimedia.org/T194192
sed -ri "s/<svg([-[:alnum:]=\" ]*) viewBox=\"0,0,([[:digit:]\.]*),([[:digit:]\.]*)\"/<svg\1 viewBox=\"0 0 \2 \3\"/g" $i

#librsvgbug https://phabricator.wikimedia.org/phab:T207506 (<code>font-weight="normal"</code> ignored)
sed -ri "s/font-weight=\"normal\"/font-weight=\"400\"/g" $i

if [ $T35245tspan = 'YES' ]; then
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:] \'\+=\.\%\)→])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:] \'\+=\.\%\)→])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:] \'\+=\.\%\)→])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:] \'\+=\.\%\)→])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:] \'\+=\.\%\)→])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:] \'\+=\.\%\)→])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:] \'\+=\.\%\)→])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:] \'\+=\.\%\)→])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:] \'\+=\.\%\)→])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:] \'\+=\.\%\)→])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:] \'\+=\.\%\)→])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
sed -ri "s/<tspan([-[:alnum:]\.\"\#\ =]*) x=\"([-[:digit:]\.]+)( |,)([-[:digit:]\. ,]+)\"([-[:alnum:]\.\"\#\ =]*)>([[:alnum:] \'\+=\.\%\)→])/<tspan x=\"\2\"\1\5>\6<\/tspan><tspan x=\"\4\"\1\5>/g" $i # remove multipe x-koordinates in tspan (solves librsvg-Bug)
fi

cp -f $i $2

python /data/project/shared/pywikipedia/core/scripts/upload.py $i -keep -ignorewarn -noverify -descfile WorkaroundBotsvg2validsvg.sh

#rm $i

