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
   chmod u+r ./${fileSource}
   cp ./${fileSource} ./${file}r.svg
   mv ./${fileSource} ./${file}.xml
   sed -ri "s/inkscape:version=\"0.(4[\. r[:digit:]]+|91 r13725)\"//g" ./${file}r.svg # https://bugs.launchpad.net/inkscape/+bug/1763190
   #inkscape --with-gui ./${file}r.svg --verb=DialogDocumentProperties --verb=FitCanvasToDrawing --export-plain-svg=${file}rR.svg --verb=FileSave --verb=FileClose --verb=FileQuit
   inkscape1  --with-gui ./${file}r.svg --actions='DialogDocumentProperties;FitCanvasToDrawing;FileSave;FileClose;FileQuit'

   
   scour -i ./${file}r.svg -o ./${file}rs.svg --disable-style-to-xml --keep-unreferenced-defs --indent=space --nindent=1 --keep-editor-data
   
      #remove useless metadata
   sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<metadata id=\"metadata[[:digit:]]*\">[[:space:]\r\n]*<rdf:RDF>[[:space:]\r\n]*<cc:Work rdf:about=\"\">[[:space:]\r\n]*<dc:format>image\/svg+xml<\/dc:format>[[:space:]\r\n]*<dc:type rdf:resource=\"http:\/\/purl.org\/dc\/dcmitype\/StillImage\"\/>[[:space:]\r\n]*<dc:title\/>[[:space:]\r\n]*<\/cc:Work>[[:space:]\r\n]*<\/rdf:RDF>[[:space:]\r\n]*<\/metadata>//" ${file}rs.svg
   
   # <sodipodi:namedview id="namedview12" bordercolor="#666666" borderopacity="1" gridtolerance="10" guidetolerance="10" inkscape:current-layer="svg10" inkscape:cx="-4.1992188" inkscape:cy="848.92578" inkscape:pageopacity="0" inkscape:pageshadow="2" inkscape:window-height="480" inkscape:window-maximized="0" inkscape:window-width="640" inkscape:window-x="0" inkscape:window-y="0" inkscape:zoom="2.36" objecttolerance="10" pagecolor="#ffffff" showgrid="false"/>
   sed -i "s/<sodipodi:namedview id=\"namedview[[:digit:]]*\" bordercolor=\"#666666\" borderopacity=\"1\" gridtolerance=\"10\" guidetolerance=\"10\" inkscape:current-layer=\"svg[[:digit:]]*\" inkscape:cx=\"[-[:digit:].]*\" inkscape:cy=\"[-[:digit:].]*\" inkscape:pageopacity=\"0\" inkscape:pageshadow=\"2\" inkscape:window-height=\"480\" inkscape:window-maximized=\"0\" inkscape:window-width=\"640\" inkscape:window-x=\"0\" inkscape:window-y=\"0\" inkscape:zoom=\"[.[:digit:]]*\" objecttolerance=\"10\" pagecolor=\"#ffffff\" showgrid=\"false\"\/>//" ${file}rs.svg
   
   mv ./${file}r.svg ./${file}r.xml
  fi
 else
     echo "no file $fileSource found!"
 fi
 
 
 
done



echo "$count file(s) converted!"
