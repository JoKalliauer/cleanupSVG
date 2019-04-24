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

for fileSource in *.$sourceType

do
 if [ -f "$fileSource" ]; then    
   count=$((count+1))
   file=$(echo $fileSource | cut -d'.' -f1)
   echo $count". "$fileSource" -> "${file}r.$outputType
  if [ "$outputType" = "svg" ];then
   #svgcleaner ${fileSource} ./${file}Cu.svg --join-style-attributes all --join-arcto-flags no --remove-declarations no --remove-nonsvg-elements no --paths-to-relative no --remove-unused-segments no --convert-segments no  --allow-bigger-file --indent 1 --remove-metadata no --remove-nonsvg-attributes no
   #mv ./${fileSource} ./${file}4.xml
   #cp ./${file}Cu.svg ./${file}C.xml
   cp ./${fileSource} ./${file}m.svg
   mv ./${fileSource} ./${file}.xml

   
      #remove useless metadata
   sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<metadata id=\"metadata[[:digit:]]*\">[[:space:]\r\n]*<rdf:RDF>[[:space:]\r\n]*<cc:Work rdf:about=\"\">[[:space:]\r\n]*<dc:format>image\/svg+xml<\/dc:format>[[:space:]\r\n]*<dc:type rdf:resource=\"http:\/\/purl.org\/dc\/dcmitype\/StillImage\"\/>[[:space:]\r\n]*<dc:title\/>[[:space:]\r\n]*<\/cc:Work>[[:space:]\r\n]*<\/rdf:RDF>[[:space:]\r\n]*<\/metadata>//" ${file}m.svg
   
   
   #<sodipodi:namedview id="namedview8" bordercolor="#666666" borderopacity="1" gridtolerance="10" guidetolerance="10" inkscape:current-layer="svg12" inkscape:cx="201.15062" inkscape:cy="19.511439" inkscape:pageopacity="0" inkscape:pageshadow="2" inkscape:window-height="480" inkscape:window-maximized="0" inkscape:window-width="640" inkscape:window-x="0" inkscape:window-y="0" inkscape:zoom="0.71339798" objecttolerance="10" pagecolor="#ffffff" showgrid="false"/>
   sed -i "s/<sodipodi:namedview id=\"namedview[[:digit:]]*\" bordercolor=\"#666666\" borderopacity=\"1\" gridtolerance=\"10\" guidetolerance=\"10\" inkscape:current-layer=\"svg[[:digit:]]*\" inkscape:cx=\"[[:digit:].]*\" inkscape:cy=\"[-[:digit:].]*\" inkscape:pageopacity=\"0\" inkscape:pageshadow=\"2\" inkscape:window-height=\"480\" inkscape:window-maximized=\"0\" inkscape:window-width=\"640\" inkscape:window-x=\"0\" inkscape:window-y=\"0\" inkscape:zoom=\"0.[[:digit:]]*\" objecttolerance=\"10\" pagecolor=\"#ffffff\" showgrid=\"false\"\/>//" ${file}m.svg
   

  fi
 else
     echo "no file $fileSource found!"
 fi
 
 
 
done



echo "$count file(s) converted!"
