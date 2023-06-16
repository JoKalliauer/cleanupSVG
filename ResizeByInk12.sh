#!/bin/sh

#Author: Johannes Kalliauer

#last Changes: (by Johannes Kalliauer)
#2017-10-29 11h06 defined inkscape alias (Johannes Kalliauer)
#2023-06-13 simplified and updated to Ink 1.2.2

echo
#needed if in the bashrc ist defined: export alias inkscape='/cygdrive/c/Program\ Files/Inkscape/inkscape.com'
if [ -z ${inkscape+x} ]; then
 echo not def
else
 echo $inkscape
 alias inkscape=$inkscape
fi

#Input parameters:
valid=1


count=0


#echo "This script allows you to convert all files in this folder from one file type to another."

for fileSource in *.svg

do
 if [ -f "$fileSource" ]; then
   count=$((count+1))
   file=$(echo $fileSource | cut -d'.' -f1)
   echo $count". "$fileSource" -> "${file}r.svg
   chmod u+r ./${fileSource}
   #cp ./${fileSource} ./${file}r.svg
   inkscape --export-type="svg" --export-area-drawing  -o ./${file}r.svg ./${fileSource}
   echo ...
   mv ./${fileSource} ./${file}.xml
   sed -ri "s/inkscape:version=\"0.(4[\. r[:digit:]]+|91 r13725)\"//g" ./${file}r.svg # https://bugs.launchpad.net/inkscape/+bug/1763190
   #inkscape  --with-gui ./${file}r.svg --actions='DialogDocumentProperties;fit-canvas-to-selection;FitCanvasToDrawing;FileSave;FileClose;FileQuit' --batch-process
   inkscape  --with-gui ./${file}r.svg --actions=fit-canvas-to-selection --batch-process
   echo ---
   


   scour -i ./${file}r.svg -o ./${file}rs.svg --disable-style-to-xml --keep-unreferenced-defs --indent=space --nindent=1 --keep-editor-data

      #remove useless metadata
   sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<metadata id=\"metadata[[:digit:]]*\">[[:space:]\r\n]*<rdf:RDF>[[:space:]\r\n]*<cc:Work rdf:about=\"\">[[:space:]\r\n]*<dc:format>image\/svg+xml<\/dc:format>[[:space:]\r\n]*<dc:type rdf:resource=\"http:\/\/purl.org\/dc\/dcmitype\/StillImage\"\/>[[:space:]\r\n]*<dc:title\/>[[:space:]\r\n]*<\/cc:Work>[[:space:]\r\n]*<\/rdf:RDF>[[:space:]\r\n]*<\/metadata>//" ${file}rs.svg

   # see validBySed.sh
   sed -ri "s/<sodipodi:namedview( id=\"namedview[[:digit:]]*\"|) bordercolor=\"#666666\" borderopacity=\"1(.0|)\"( gridtolerance=\"10\" guidetolerance=\"10\"|) inkscape:current-layer=\"[[:digit:]svgEbene_]*\" inkscape:cx=\"[-[:digit:].]*\" inkscape:cy=\"[-[:digit:].]*\"( inkscape:pagecheckerboard=\"0\"|) inkscape:pageopacity=\"0(.0|)\" inkscape:pageshadow=\"2\" inkscape:window-height=\"(480|[0179]*)\" inkscape:window-maximized=\"(0|1)\" inkscape:window-width=\"(640|[01259]*)\" inkscape:window-x=\"(0|[-268]*)\" inkscape:window-y=\"(0|[-238]*)\" inkscape:zoom=\"[[:digit:].]*\"( objecttolerance=\"10\"|) pagecolor=\"#ffffff\"( showgrid=\"false\"|)\/>//" ${file}rs.svg
 sed -i "s/ inkscape:version=\"1.1 (c68e22c387, 2021-05-23)\"//" ${file}rs.svg
 sed -i "s/ sodipodi:docname=\"[[:alnum:]_,.]*\"//" ${file}rs.svg

   mv ./${file}r.svg ./${file}r.xml
 else
     echo "no file $fileSource found!"
 fi



done



echo "$count file(s) converted!"
