#!/bin/bash

# transform="scale(.99982 1.0002)"
# transform="scale(0.99981771,1.0001823)"

for file in *.svg;do
 chmod u+r "${file}" #for running in cygwin

## == Remove scecial characters in filename ==

export i=$file #i will be overritan later, just for debugging
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


 sed -ri "s/ transform=\"scale\((0|).999(8|9)[[:digit:]]*( |,)1.000(0|1|2)[[:digit:]]*\)\"/ transform=\"scale\(1,1.000\)\"/g" $i
# sed -ri "s/ transform=\"scale\((0|).99[[:digit:]]*( |,)1.0(0|1)[[:digit:]]*\)\"/ transform=\"scale\(1,1.000\)\"/g" $i # more aggressive, replaces text
 sed -ri "s/ transform=\"scale\(1.000(0|1|2)[[:digit:]]*( |,)(0|).999(8|9)[[:digit:]]*\)\"/ transform=\"scale\(1.000,1\)\"/g" $i
# sed -ri "s/ transform=\"scale\(1.000(0|1|2|3)[[:digit:]]*( |,)(0|).999(7|8|9)[[:digit:]]*\)\"/ transform=\"scale\(1.000,1\)\"/g" $i # more aggressive, replaces text
 sed -ri "s/(scale|matrix)\(.9999(8|9)[[:digit:]]*/\1\(1/g" $i
 #sed -ri "s/(scale|matrix)\(1.00(0|1|2|3|4|5|6)[[:digit:]]*/\1\(1/g" $i
 #sed -ri "s/ transform=\"matrix\(.9999 [-[:digit:].]* [-[:digit:].]* .9999/\1\(1/g" $i
 sed -ri "s/ opacity=\".9(7|8|9)\"/ opacity=\"1\"/g" $i



 # transform="matrix(.9999 -.01414 .01414 .9999 0 0)"

echo $i finish

done
