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
   echo $count". "$fileSource" -> "${file}u.$outputType
  if [ "$outputType" = "png" ];then
   read -p "With what dpi should it be exported (e.g. 300)? " dpi
   inkscape $fileSource --export-$outputType=$file.$outputType --export-dpi=$dpi
  elif [ "$outputType" = "svg" ];then
   #svgcleaner ${fileSource} ./${file}Cu.svg --join-style-attributes all --join-arcto-flags no --remove-declarations no --remove-nonsvg-elements no --paths-to-relative no --remove-unused-segments no --convert-segments no  --allow-bigger-file --indent 1 --remove-metadata no --remove-nonsvg-attributes no
   #mv ./${fileSource} ./${file}4.xml
   #cp ./${file}Cu.svg ./${file}C.xml
   cp ./${fileSource} ./${file}u.svg
   mv ./${fileSource} ./${file}.xml
   inkscape ./${file}u.svg --verb=EditSelectAll --verb=SelectionUnGroup --verb=FileSave --verb=FileClose --verb=FileQuit
   #svgcleaner ./${file}Cu.svg ./${file}CuC.svg --join-style-attributes all --join-arcto-flags no --remove-declarations no --remove-nonsvg-elements no --paths-to-relative no --remove-unused-segments no --convert-segments no  --allow-bigger-file --indent 1 --remove-metadata no --remove-nonsvg-attributes no
   scour -i ./${file}u.svg -o ./${file}us.svg --disable-style-to-xml --keep-unreferenced-defs --disable-embed-rasters --indent=space --nindent=1 --keep-editor-data
   
#W3C: element "rdf:RDF" undefined
#Nu: Warning: This validator does not validate RDF. RDF subtrees go unchecked.
# use scour/svgcleaner/svgo or https://de.wikipedia.org/wiki/Benutzer:Marsupilami/Inkscape-FAQ#Wie_erstelle_ich_eine_Datei_die_dem_Standard_SVG_1.1_entspricht?
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/[[:space:]\r\n]*<rdf:RDF>[[:space:]\r\n]*<cc:Work( rdf:about=\"\"|)>[[:space:]\r\n]*(<dc:format>[[:space:]\r\n]*image\/svg\+xml[[:space:]\r\n]*<\/dc:format>|<dc:format\/>)[[:space:]\r\n]*<dc:type rdf:resource=\"http:\/\/purl.org\/dc\/dcmitype\/StillImage\"\/>([[:space:]\r\n]*<dc:title\/>|)[[:space:]\r\n]*<\/cc:Work>[[:space:]\r\n]*<\/rdf:RDF>//" ${file}us.svg
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<metadata id=\"metadata[[:digit:]]*\">[[:space:]\r\n]*<\/metadata>//" ${file}us.svg

   mv ./${file}u.svg ./${file}u.xml
  else
   inkscape $fileSource --export-$outputType=$file.$outputType
  fi
 else
     echo "no file $fileSource found!"
 fi
 
 
 
done



echo "$count file(s) converted!"
