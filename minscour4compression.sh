#!/bin/bash

for file in *.svg;do
# export file=min.svg
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=${fileN%.svg}
export i=${tmp}s.svg

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
 export META="--remove-metadata" # --remove-descriptive-elements
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

echo scour ${file} to $i begin, min=${minfilesize}, meta=$meta, META= $META, INDENT=$INDENT

scour -i ${file} -o $i --keep-unreferenced-defs --remove-descriptions --strip-xml-space  --set-precision=6 $META $INDENT --renderer-workaround --disable-style-to-xml  --set-c-precision=6 --protect-ids-noninkscape  --disable-simplify-colors  --keep-editor-data # --enable-comment-stripping --create-groups  #--enable-viewboxing #  

# == min == 
# not --enable-comment-stripping # keep comments
# not --remove-titles
# not  --enable-id-stripping
#no --shorten-ids 

### === CSS ===
# --keep-unreferenced-defs # https://github.com/scour-project/scour/issues/155
# --disable-style-to-xml # https://github.com/scour-project/scour/issues/176
# --disable-simplify-colors # https://github.com/scour-project/scour/issues/221
# not #--enable-id-stripping # https://github.com/scour-project/scour/issues/164
# not #--shorten-ids # https://github.com/scour-project/scour/issues/164

## == Bug ==

#--enable-viewboxing
##Changes size of view
##can create Hairline-cracks f.e in https://commons.wikimedia.org/wiki/File:Mn_coa_zavkhan_aimag.svg

#--create-groups #https://commons.wikimedia.org/wiki/File:CIA_WorldFactBook-Political_world.svg

# --create-groups # https://github.com/scour-project/scour/issues/196 (but it is 

# --set-precision=6 #https://github.com/scour-project/scour/issues/219
#--set-precision=5 # https://commons.wikimedia.org/wiki/File:Porr_logo.svg
#--set-c-precision=4 # https://commons.wikimedia.org/wiki/File:Flower_soft.svg
#--set-c-precision=5 #https://commons.wikimedia.org/wiki/File:Anatomy_of_Human_Ear_with_Cochlear_Frequency_Mapping.svg https://commons.wikimedia.org/wiki/File:MichelinStar.svg
#--set-c-precision=6 same precision as --set-precision=6 # https://commons.wikimedia.org/wiki/File:MichelinStar.svg

#echo mv ./${file} ./${tmp}3.xml
mv ./${file} ./${tmp}3.xml

echo scour $i finish

done

DeactivateAll=<<END

scour min.svg output.svg --disable-simplify-colors --disable-style-to-xml  --disable-group-collapsing --keep-editor-data --keep-unreferenced-defs --no-renderer-workaround --protect-ids-noninkscape  --disable-embed-rasters

END

ActivateAll=<<END

scour min.svg output.svg --enable-comment-stripping --remove-titles --remove-descriptions --strip-xml-space  --create-groups --remove-metadata --remove-descriptive-elements --renderer-workaround  --enable-viewboxing --enable-id-stripping --shorten-ids 

END

