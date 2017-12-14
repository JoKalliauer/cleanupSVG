#!/bin/bash

for file in *.svg;do
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=$(echo $fileN | cut -f1 -d".")
export i=${tmp}c.svg

if [ -z ${precisiondigits+x} ]; then
 precisiondigits=5
 precisiondigitsN=5
else
 if [ $precisiondigits -le 0 ]; then
  precisiondigits=1
 fi
 if [ -z ${precisiondigitsN+x} ]; then
  precisiondigitsN=$precisiondigits
 fi
 #echo precisiondigitsN is $precisiondigitsN
fi

if [ -z ${minfilesize+x} ]; then
 minfilesize=0
fi 

echo 
echo cleaner ${file} to $i begin, dig=${precisiondigits}, digN=${precisiondigitsN}, min=${minfilesize}

if [ $minfilesize == 0 ]; then
 if [ -z ${meta+x} ]; then
  meta=0
  echo not written yet
 else
  echo $meta
  if [ $meta == 0 ]; then  
   echo delete Metadata
   svgcleaner.exe $file $i --apply-transform-to-gradients yes --apply-transform-to-paths yes --apply-transform-to-shapes yes --convert-segments yes --convert-shapes yes --coordinates-precision $precisiondigitsN --group-by-style yes --indent 1 --join-arcto-flags no --join-style-attributes no --merge-gradients yes --paths-coordinates-precision $precisiondigitsN --paths-to-relative yes --properties-precision $precisiondigitsN --regroup-gradient-stops yes --remove-comments yes --remove-declarations no --remove-default-attributes yes --remove-desc yes --remove-dupl-cmd-in-paths yes --remove-dupl-fegaussianblur yes --remove-dupl-lineargradient yes --remove-dupl-radialgradient yes --remove-gradient-attributes yes --remove-invalid-stops yes --remove-invisible-elements yes --remove-metadata yes --remove-needless-attributes yes --remove-nonsvg-attributes yes --remove-nonsvg-elements yes --remove-text-attributes yes --remove-title yes --remove-unreferenced-ids yes --remove-unresolved-classes yes --remove-unused-coordinates yes --remove-unused-defs yes --remove-unused-segments yes --remove-version yes --remove-xmlns-xlink-attribute yes --resolve-use yes --simplify-transforms yes --transforms-precision $precisiondigitsN --trim-colors yes --trim-ids yes --trim-paths yes --ungroup-defs yes --ungroup-groups yes --use-implicit-cmds yes
  fi
 fi
elif [ $minfilesize == 1 ] && [ $meta == 0 ]; then
  echo not written yet
elif [ $minfilesize == 1 ] && [ $meta == 1 ]; then
  echo not written yet
else
 echo nothing done, please change input variables,current: dig=${precisiondigits}, min=${minfilesize}, meta=${meta}
fi

echo mv ./${file} ./${tmp}bak3.xml
mv ./${file} ./${tmp}bak3.xml

echo scour $i finish

done

