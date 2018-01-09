#!/bin/bash

for file in *.svg;do
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=$(echo $fileN | cut -f1 -d".")
export i=${tmp}s.svg

if [ -z ${precisiondigits+x} ]; then
 precisiondigits=3 # https://commons.wikimedia.org/wiki/File:LageplanStrasse.svg https://commons.wikimedia.org/wiki/File:Dojikko2.3.svg
 precisiondigitsN=5 # https://commons.wikimedia.org/wiki/File:Porr_logo.svg
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
 export META= 
elif [ $meta == 0 ]; then
 export META="--remove-metadata --remove-descriptive-elements"
 echo delete META=$META
else
 echo imput not allowed meta is $meta
fi

if [ $minfilesize == 0 ]; then
 export INDENT=" --indent=space --nindent=1"
elif [ $minfilesize == 1 ]; then
 export INDENT="--indent=none --no-line-breaks"
else
 echo some error minfilesize is $minfilesize
fi

echo scour ${file} to $i begin, dig=${precisiondigits}, digN=${precisiondigitsN}, min=${minfilesize}, meta=$meta, META= $META, INDENT=$INDENT

scour -i ${file} -o $i --enable-comment-stripping --remove-titles --remove-descriptions --disable-embed-rasters --strip-xml-space  --set-precision=${precisiondigitsN} --set-c-precision=${precisiondigits} --create-groups $META $INDENT --renderer-workaround # --enable-viewboxing #--keep-unreferenced-defs # --enable-id-stripping 


#echo mv ./${file} ./${tmp}3.xml
mv ./${file} ./${tmp}3.xml

echo scour $i finish

done

DeactivateAll=<<END

scour min.svg output.svg --disable-simplify-colors --disable-style-to-xml  --disable-group-collapsing --keep-editor-data --keep-unreferenced-defs --no-renderer-workaround --protect-ids-noninkscape 

END

ActivateAll=<<END

scour min.svg output.svg --enable-comment-stripping --remove-titles --remove-descriptions --disable-embed-rasters --strip-xml-space  --create-groups --remove-metadata --remove-descriptive-elements --renderer-workaround  --enable-viewboxing --enable-id-stripping --shorten-ids 

END

