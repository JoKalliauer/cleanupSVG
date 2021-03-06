#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

#./ScourFull.sh #damit man einzeilTags hat
##./einzeilTags.sh

for file in *.svg;do

## == Remove scecial characters in filename ==

#export i=$file #i will be overwritten later, just for debugging
export new="${file//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_\+]/}"
if [ $new == '*.svg' ]; then #new has to be controlled because it might have "-" which confuses bash
 echo "no file, (or filename does not contain any default latin character (a-z) )"
 break
fi
export tmp=${new%.svg}

#If you want to overwrite the existing file, without any backup, delete the following three lines
export i=${tmp}P.svg
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml
echo ${tmp}
echo $file

sleep 1

# export i=test.txt

echo 
echo $i start:
 
 #----
    #!/bin/bash
    
    #defining file
    #export i=test.svg
    
    perl -pe 's/viewBox="(\d+) (\d+) (\d+) (\d+)"/"viewBox=\"".($1*10)." ".($2*10)." ".($3*10)." ".($4*10)."\""/eg' <$i >Out.svg
 #----



 
echo $i finish



done
comment=<<END
./CleanerFull.sh #wegen Inkscape-Bug

#./PosibleUngroup.sh
./UngroupByInkscape.sh #for removing the groups and increasing font-size
#./einzeilTags.sh
./Rounding.sh #for removing rounding errors


#./CleanerFull.sh
./IskartOptimizer.sh #for reducing file size

./svg2validsvg.sh #for correcting the png-files and adding DTD
#./cleaner4compression.sh
#./o4compression.sh #https://github.com/svg/svgo/issues/1001
#./scour4compression.sh #https://github.com/scour-project/scour/issues/202
#./CleanerFull.sh
#./RasterOptimizer.sh
./fontReplace.sh #for replacing Arial with Liberation Sans
#./validBycleaner.sh
#./svg2validsvg.sh
#./validByScour.sh
END
