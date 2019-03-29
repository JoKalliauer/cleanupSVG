#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

#./ScourFull.sh #damit man einzeilTags hat
###./einzeilTags.sh

for file in *.svg;do

## == Remove scecial characters in filename ==

#export i=$file #i will be overwritten later, just for debugging
export new="${file//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_\+]/}"
if [ $new == '*.svg' ]; then #new has to be controlled because it might have "-" which confuses bash
 echo "no file, (or filename does not contain any default latin character (a-z) )"
 break
fi
export tmp=${new%.svg}

if [ $overwriteJK == 'YES' ]; then
 echo file will be overwritten
 i=$file
else 
 echo not overwritten
 #If you want to overwrite the exisiting file, without any backup, delete the following three lines
 i=${tmp}_.svg
 cp ./"${file}" $i
 mv ./"${file}" ./${tmp}1.xml
fi

if [ -z ${1+x} ]; then
 echo kein Input, verwende $i
else
 echo Input $1, verwende $1 anstatt $i
 i=$1
fi

echo 
echo $i start:

#<tspan x="0,35.76,39.42,43.07,75.19,78.84,82.5,114.61,118.27,121.92,154.03,157.69,161.35" y="0">0200400600800</tspan>
#          <tspan                         x=                                                                     >                        /
# sed -ri 's/(<tspan[^>]* x=")([^ "]+) ([^"]+)("[^>]*>)(.)([^<]+)(<\/tspan>)/\1\2\4\5\7\1\3\4\6\7/g' $i suggested by TilmannR in https://commons.wikimedia.org/wiki/User_talk:JoKalliauer#Fixing_phab:T35245_in_(R)-Citronellal_Structural_Formula_V.1_1.svg
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

 
 sed -ri "s/ unicode-bidi=\"embed\"//g" $i

echo $i finish



done
#
#./CleanerFull.sh #wegen Inkscape-Bug
#
##./PosibleUngroup.sh
#./UngroupByInkscape.sh #for removing the groups and increasing font-size
##./einzeilTags.sh
#./Rounding.sh #for removing rounding errors
#
#
##./CleanerFull.sh
#./IskartOptimizer.sh #for reducing file size
#
#./svg2validsvg.sh #for correcting the png-files and adding DTD
##./cleaner4compression.sh
##./o4compression.sh #https://github.com/svg/svgo/issues/1001
##./scour4compression.sh #https://github.com/scour-project/scour/issues/202
##./CleanerFull.sh
##./RasterOptimizer.sh
#./fontReplace.sh #for replacing Arial with Liberation Sans
##./validBycleaner.sh
##./svg2validsvg.sh
##./validByScour.sh
