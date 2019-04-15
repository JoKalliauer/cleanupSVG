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
   cp ./${fileSource} ./${file}f.svg
   mv ./${fileSource} ./${file}.xml
   
   #remove empty flow Text in svg (also update svg2validsvg.sh)
   sed -ri 's/<flowPara([-[:alnum:]\" \.\:\%\=\;#\(\)]*)\/>//g;s/<flowRoot\/>//g' ${file}f.svg
   sed -i 's/<flowSpan[-[:alnum:]=\":;\. ]*>[[:space:]]*<\/flowSpan>//g' ${file}f.svg
   sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion(\/|[[:alnum:]\"= ]*>[[:space:]]*<(path|rect) [-[:alnum:]\. \"\=:]*\/>[[:space:]]*<\/flowRegion)>[[:space:]]*(<flowDiv\/>|)[[:space:]]*<\/flowRoot>//g" ${file}f.svg #delete empty flowRoot
   sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" ]*)>[[:space:]]*(<path[-[:alnum:]\.=\"\ \#]*\/>|<rect( id=\"[-[:alnum:]]*\"|) x=\"([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([[:lower:][:digit:]=\.\" \#:]+)\/>)[[:space:]]*<\/flowRegion>[[:space:]]*(|<flowPara([-[:alnum:]\.=\" \:\#;% ]*)>([[:space:] ]*)<\/flowPara>)[[:space:]]*<\/flowRoot>//g" ${file}f.svg ##delete flowRoot only containing spaces
   
   sed -ri "s/inkscape:version=\"0.(4[\. r[:digit:]]+|91 r13725)\"//g" ./${file}f.svg # https://bugs.launchpad.net/inkscape/+bug/1763190

   inkscape ./${file}f.svg --verb=EditSelectAll --verb=ObjectFlowtextToText --verb=FileSave --verb=FileClose --verb=FileQuit
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
