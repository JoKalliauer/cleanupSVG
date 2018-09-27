#!/bin/bash

# transform="scale(.99982 1.0002)"
# transform="scale(0.99981771,1.0001823)"

for file in *.svg;do

## == Remove scecial characters in filename ==

#export i=$file #i will be overritan later, just for debugging
export new="${file//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_\+]/}"
if [ $new == '*.svg' ]; then #new has to be controlled because it might have "-" which confuses bash
 echo "no file, (or filename does not contain any default latin character (a-z) )"
 break
fi
export tmp=${new%.svg}

#If you want to overwrite the exisiting file, without any backup, delete the following three lines
export i=${tmp}R.svg
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml

echo 
echo $i start:

 sed -ri "s/ transform=\"scale\(.999(8|9)[[:digit:]]*( |,)1.000(1|2)[[:digit:]]*\)\"/ transform=\"scale\(1,1.000\)\"/g" $i

echo $i finish

done
