#!/bin/sh

#Author: Johannes Deml, Johannes Kalliauer
#Source: http://www.inkscapeforum.com/viewtopic.php?t=16743
#Download: http://ge.tt/7C8JFmF1/v/0?c
#Download date: 2017-10-29

#last Changes: (by Johannes Kalliauer)
#2017-10-29 11h06 defined inkscape alias (Johannes Kalliauer)

echo
#needed if in the bashrc ist defined: export alias inkscape='/cygdrive/c/Program\ Files/Inkscape/inkscape.com'
if [ -z ${inkscape+x} ]; then
 echo not def
else
 echo $inkscape
 alias inkscape=$inkscape
fi

#Input parameters:
#alias inkscape='/cygdrive/c/Program\ Files/Inkscape/inkscape.com' #2017-10-29 11h06 (by Johannes Kalliauer)
#alias inkscape.exe='/cygdrive/c/Program\ Files/Inkscape/inkscape.exe'
sourceType="svg"
outputType="svg"
valid=1


count=0
validInput1="svg"
validInput2="pdf"
validInput3="eps"
validOutput1="eps"
validOutput2="pdf"
validOutput3="png"
validOutput4="svg"
validOutput5="plain-svg"


#echo "This script allows you to convert all files in this folder from one file type to another."

#valid=0
while [ "$valid" != "1" ]
do
    echo "Allowed file types for source: $validInput1, $validInput2, $validInput3"
	read -p "What file type do you want to use as a source? " sourceType
    if [ "$sourceType" = "$validInput1" ] || [ "$sourceType" = "$validInput2" ] || [ "$sourceType" = "$validInput3" ]; then
        valid=1
    else
        echo "Invalid input! Please use one of the following: $validInput1, $validInput2, $validInput3"
    fi
done

#valid=0
while [ "$valid" != "1" ]
do
    echo "Allowed file types for output: $validOutput1, $validOutput2, $validOutput3"
	read -p "What file type do you want to convert to? " outputType
    if [ "$outputType" = "$validOutput1" ] || [ "$outputType" = "$validOutput2" ] || [ "$outputType" = "$validOutput3" ] || [ "$outputType" = "$validOutput4" ] || [ "$outputType" = "$validOutput5" ]; then
        valid=1
    else
        echo "Invalid input! Please use one of the following: $validOutput1, $validOutput2, $validOutput3"
    fi
done

for fileSource in *.$sourceType

do
 if [ -f "$fileSource" ]; then    
   count=$((count+1))
   file=$(echo $fileSource | cut -d'.' -f1)
   echo $count". "$fileSource" -> "${file}f.$outputType
  if [ "$outputType" = "png" ];then
   break
  elif [ "$outputType" = "svg" ];then
   #svgcleaner ${fileSource} ./${file}Cu.svg --join-style-attributes all --join-arcto-flags no --remove-declarations no --remove-nonsvg-elements no --paths-to-relative no --remove-unused-segments no --convert-segments no  --allow-bigger-file --indent 1 --remove-metadata no --remove-nonsvg-attributes no
   #mv ./${fileSource} ./${file}4.xml
   #cp ./${file}Cu.svg ./${file}C.xml
   
   #scour -i ./${fileSource} -o ./${file}s.svg --disable-style-to-xml --keep-unreferenced-defs --indent=space --nindent=1  --keep-editor-data #https://gitlab.com/inkscape/inkscape/issues/117
   
   #svgo -i ${file} -o ${file}o.svg $INDENT -p 3 $META --disable=removeHiddenElems --disable=removeUnknownsAndDefaults --disable=convertTransform --disable=convertPathData --disable=mergePaths --enable=removeScriptElement --disable=removeXMLProcInst --disable=convertStyleToAttrs --enable=cleanupAttrs --enable=cleanupEnableBackground --disable=cleanupIDs --disable=cleanupNumericValues --enable=convertColors --disable=convertShapeToPath --disable=inlineStyles  --disable=minifyStyles --enable=moveElemsAttrsToGroup --enable=moveGroupAttrsToElems  --enable=removeAttrs --disable=removeComments --enable=removeDesc --disable=removeEditorsNSData --enable=removeEmptyAttrs --enable=removeEmptyContainers --enable=removeEmptyText --enable=removeNonInheritableGroupAttrs --disable=removeRasterImages --disable=removeTitle --enable=removeUnusedNS --enable=removeUselessDefs --enable=removeUselessStrokeAndFill --enable=removeViewBox --enable=sortAttrs --disable=removeDoctype --enable={addAttributesToSVGElement}  --disable=collapseGroups  --disable=removeStyleElement
   
   cp ./${file}.svg ./${file}f.svg
   mv ./${fileSource} ./${file}.xml
   #mv ./${file}o.svg ./${file}o.xml
   
   #remove empty flow Text in svg (first update svg2validsvg.sh)
   sed -ri 's/<flowPara([-[:alnum:]\" \.\:\%\=\;#\(\)]*)\/>//g;s/<flowRoot([-[:alnum:]" \.:%=;]*)\/>//g' ${file}f.svg
   sed -i 's/<flowSpan[-[:alnum:]=\":;\. ]*>[[:space:]]*<\/flowSpan>//g' ${file}f.svg
   sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion(\/|[[:alnum:]\"= ]*>[[:space:]]*<(path|rect) [-[:alnum:]\. \"\=:]*\/>[[:space:]]*<\/flowRegion)>[[:space:]]*(<flowDiv\/>|)[[:space:]]*<\/flowRoot>//g" ${file}f.svg #delete empty flowRoot
   sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" ]*)>[[:space:]]*(<path[-[:alnum:]\.=\"\ \#]*\/>|<rect( id=\"[-[:alnum:]]*\"|) x=\"([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([[:lower:][:digit:]=\.\" \#:]+)\/>)[[:space:]]*<\/flowRegion>[[:space:]]*(|<flowPara([-[:alnum:]\.=\" \:\#;% ]*)>([[:space:] ]*)<\/flowPara>)[[:space:]]*<\/flowRoot>//g" ${file}f.svg ##delete flowRoot only containing spaces
   
   sed -ri "s/inkscape:version=\"0.(4[\. r[:digit:]]+|91 r13725)\"//g" ./${file}f.svg # https://bugs.launchpad.net/inkscape/+bug/1763190
   
   inkscape ./${file}f.svg --verb=EditSelectAll --verb=ObjectFlowtextToText --verb=FileSave --verb=FileClose --verb=FileQuit
   
   #remove useless metadata see validbySed
   sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<metadata id=\"metadata[[:digit:]]*\">[[:space:]\r\n]*<rdf:RDF>[[:space:]\r\n]*<cc:Work rdf:about=\"\">[[:space:]\r\n]*<dc:format>image\/svg+xml<\/dc:format>[[:space:]\r\n]*<dc:type rdf:resource=\"http:\/\/purl.org\/dc\/dcmitype\/StillImage\"\/>[[:space:]\r\n]*<dc:title\/>[[:space:]\r\n]*<\/cc:Work>[[:space:]\r\n]*<\/rdf:RDF>[[:space:]\r\n]*<\/metadata>//" ${file}f.svg
   
   sed -i "s/<sodipodi:namedview id=\"namedview[[:digit:]]*\" bordercolor=\"#666666\" borderopacity=\"1\" gridtolerance=\"10\" guidetolerance=\"10\" inkscape:current-layer=\"svg[[:digit:]]*\" inkscape:cx=\"[[:digit:].]*\" inkscape:cy=\"[-[:digit:].]*\" inkscape:pageopacity=\"0\" inkscape:pageshadow=\"2\" inkscape:window-height=\"480\" inkscape:window-maximized=\"0\" inkscape:window-width=\"640\" inkscape:window-x=\"0\" inkscape:window-y=\"0\" inkscape:zoom=\"0.[[:digit:]]*\" objecttolerance=\"10\" pagecolor=\"#ffffff\" showgrid=\"false\"\/>//" ${file}f.svg

   
   #svgcleaner ./${file}Cu.svg ./${file}CuC.svg --join-style-attributes all --join-arcto-flags no --remove-declarations no --remove-nonsvg-elements no --paths-to-relative no --remove-unused-segments no --convert-segments no  --allow-bigger-file --indent 1 --remove-metadata no --remove-nonsvg-attributes no
   scour -i ./${file}f.svg -o ./${file}fs.svg --disable-style-to-xml --keep-unreferenced-defs --indent=space --nindent=1  --keep-editor-data #--enable-id-stripping
   mv ./${file}f.svg ./${file}f.xml
  else
   inkscape $fileSource --export-$outputType=$file.$outputType
  fi
 else
     echo "no file $fileSource found!"
 fi
 
 
 
done



echo "$count file(s) converted!"
