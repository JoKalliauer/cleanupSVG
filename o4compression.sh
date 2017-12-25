#!/bin/bash

for file in *.svg;do
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=$(echo $fileN | cut -f1 -d".")
export i=${tmp}o.svg

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

if [ -z ${meta+x} ]; then
  meta=1 #if not specified kept meta to not make a copyright violation
fi

echo #Add a empty line to split the output

if [ $meta == 1 ]; then
 echo keep metadata
 export META="--enable=removeDoctype --disable=removeMetadata"
elif [ $meta == 0 ]; then
 export META="--disable=removeDoctype --enable=removeMetadata"
 echo delete META=$META
else
 echo imput not allowed meta is $meta
fi

if [ $minfilesize == 0 ]; then
 export INDENT="--pretty --indent=1"
elif [ $minfilesize == 1 ]; then
 export INDENT="--indent=0"
else
 echo some error minfilesize is $minfilesize
fi

echo svgo ${file} to $i begin, dig=${precisiondigits}, digN=${precisiondigitsN}, min=${minfilesize}, meta=$meta, META= $META, INDENT=$INDENT

svgo -i ${file} -o $i -p $precisiondigitsN $META --enable=removeScriptElement --disable=removeXMLProcInst --disable=removeUnknownsAndDefaults --disable=mergePaths $INDENT


echo mv ./${file} ./${tmp}5.xml
mv ./${file} ./${tmp}5.xml

echo svgo $i finish

done

