#!/bin/sh

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
#sourceType="svg"
#outputType="svg"
valid=1


count=0

for fileSource in *.svg

do
 if [ -f "$fileSource" ]; then    
   count=$((count+1))
   file=$(echo $fileSource | cut -d'.' -f1)
   echo $count". "svg" -> "${file}u.svg
   
   cp "./$fileSource" "./${file}u.svg"
   mv "./$fileSource" "./${file}.xml"
   sed -ri "s/inkscape:version=\"0.(4[\. r[:digit:]]+|91 r13725)\"//g" "./${file}u.svg" # https://bugs.launchpad.net/inkscape/+bug/1763190
   inkscape -g "./${file}u.svg" --actions='EditSelectAll;SelectionUnGroup;SelectionUnGroup;SelectionUnGroup;SelectionUnGroup;SelectionUnGroup;FileSave;FileClose;FileQuit'
   sed -ri "s/font-family:([-[:alnum:] ,']*)'([-[:alnum:] ]*)'([-[:lower:][:upper:], ']*)/font-family:\1\2\3/g" "./${file}u.svg"
   i="./${file}us.svg"
   scour -i "./${file}u.svg" -o $i --disable-style-to-xml --keep-unreferenced-defs --disable-embed-rasters --indent=space --nindent=1 --keep-editor-data
   
   #W3C: element "rdf:RDF" undefined
#Nu: Warning: This validator does not validate RDF. RDF subtrees go unchecked.
# use scour/svgcleaner/svgo or https://de.wikipedia.org/wiki/Benutzer:Marsupilami/Inkscape-FAQ#Wie_erstelle_ich_eine_Datei_die_dem_Standard_SVG_1.1_entspricht?
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/[[:space:]\r\n]*<rdf:RDF>[[:space:]\r\n]*<cc:Work( rdf:about=\"\"|)>[[:space:]\r\n]*<dc:format>image\/svg\+xml<\/dc:format>[[:space:]\r\n]*<dc:type rdf:resource=\"http:\/\/purl.org\/dc\/dcmitype\/StillImage\"\/>[[:space:]\r\n]*(<dc:title\/>|)[[:space:]\r\n]*<\/cc:Work>[[:space:]\r\n]*<\/rdf:RDF>//" $i
   #sed -i -e ':a' -e 'N' -e '$!ba' -e "s/<metadata id=\"metadata[[:digit:]]*\">[[:space:]\r\n]*<rdf:RDF>[[:space:]\r\n]*<cc:Work rdf:about=\"\">[[:space:]\r\n]*<dc:format>image\/svg+xml<\/dc:format>[[:space:]\r\n]*<dc:type rdf:resource=\"http:\/\/purl.org\/dc\/dcmitype\/StillImage\"\/>[[:space:]\r\n]*<dc:title\/>[[:space:]\r\n]*<\/cc:Work>[[:space:]\r\n]*<\/rdf:RDF>[[:space:]\r\n]*<\/metadata>//" $i
   
   #<sodipodi:namedview id="namedview8" bordercolor="#666666" borderopacity="1.0" inkscape:current-layer="svg6" inkscape:cx="200" inkscape:cy="200" inkscape:pagecheckerboard="0" inkscape:pageopacity="0.0" inkscape:pageshadow="2" inkscape:window-height="1021" inkscape:window-maximized="0" inkscape:window-width="1614" inkscape:window-x="1920" inkscape:window-y="32" inkscape:zoom="1.8825" pagecolor="#ffffff" showgrid="false"/>
   sed -ri "s/<sodipodi:namedview id=\"namedview[[:digit:]]*\" bordercolor=\"#666666\" borderopacity=\"1(|.0)\"( gridtolerance=\"10\" guidetolerance=\"10\"|) inkscape:current-layer=\"svg[[:digit:]]*\" inkscape:cx=\"[[:digit:].]*\" inkscape:cy=\"[-[:digit:].]*\"(| inkscape:pagecheckerboard=\"0[.0]*\") inkscape:pageopacity=\"0(|.0)\" inkscape:pageshadow=\"2\" inkscape:window-height=\"(480|1021)\" inkscape:window-maximized=\"0\" inkscape:window-width=\"(640|1614)\" inkscape:window-x=\"(0|1920)\" inkscape:window-y=\"(0|32)\" inkscape:zoom=\"(0|1).[[:digit:]]*\"( objecttolerance=\"10\"|) pagecolor=\"#ffffff\" showgrid=\"false\"\/>//" $i
   
   mv "./${file}u.svg" "./${file}u.xml"

 else
     echo "no file $fileSource found!"
 fi
 
 
 
done



echo "$count file(s) converted!"
