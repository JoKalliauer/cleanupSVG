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
 minfilesize=0 #if not defined make an indent
fi 

if [ -z ${meta+x} ]; then
  meta=1 #if not specified kept meta to not make a copyright violation
fi

echo #Add a empty line to split the output

if [ $meta == 1 ]; then
 export META=no
elif [ $meta == 0 ] ; then
 echo delete Metadata
 export META=yes
else
 echo some error meta is $meta
fi

if [ $minfilesize == 0 ]; then
 export INDENT=1
elif [ $minfilesize == 1 ]; then
 export INDENT=none
else
 echo some error minfilesize is $minfilesize
fi

echo cleaner ${file} to $i begin, dig=${precisiondigits}, digN=${precisiondigitsN}, min=${minfilesize}, METAdelete=$META, INDENT=$INDENT

svgcleaner.exe $file $i --apply-transform-to-gradients yes --apply-transform-to-shapes yes --convert-segments yes --convert-shapes yes --coordinates-precision $precisiondigitsN --group-by-style yes --indent $INDENT --join-arcto-flags no --join-style-attributes no --merge-gradients yes --paths-coordinates-precision $precisiondigitsN --properties-precision $precisiondigitsN --regroup-gradient-stops yes --remove-comments yes --remove-declarations no --remove-default-attributes yes --remove-desc yes --remove-dupl-cmd-in-paths yes --remove-dupl-fegaussianblur yes --remove-dupl-lineargradient yes --remove-dupl-radialgradient yes --remove-gradient-attributes yes --remove-invalid-stops yes --remove-invisible-elements yes --remove-metadata $META --remove-needless-attributes yes --remove-nonsvg-attributes $META --remove-nonsvg-elements no --remove-text-attributes yes --remove-title yes --remove-unreferenced-ids yes --remove-unresolved-classes yes --remove-unused-coordinates yes --remove-unused-defs yes --remove-unused-segments yes --paths-to-relative yes --remove-version yes --remove-xmlns-xlink-attribute yes --resolve-use yes --simplify-transforms yes --transforms-precision $precisiondigitsN --trim-colors yes --trim-ids yes --trim-paths yes --ungroup-defs yes --ungroup-groups yes --use-implicit-cmds yes --allow-bigger-file # --copy-on-error --apply-transform-to-paths yes

#echo mv ./${file} ./${tmp}4.xml
mv ./${file} ./${tmp}4.xml

#echo cleaner $i finish

done

