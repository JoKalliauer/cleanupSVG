#!/bin/bash

for file in *.svg;do
# export file=min.svg
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=$(echo $fileN | cut -f1 -d".")
export i=${tmp}S.svg

echo scour ${file} to $i begin, dig=5, digC=3, min=${minfilesize}, meta=$meta, META= $META, INDENT=$INDENT

scour -i ${file} -o $i --enable-comment-stripping --strip-xml-space --remove-metadata --renderer-workaround  --remove-descriptions --enable-id-stripping --shorten-ids --set-precision=5 --set-c-precision=5 --remove-descriptive-elements --remove-titles --create-groups # --enable-viewboxing

#scour -i ${file} -o $i --enable-comment-stripping --remove-titles --remove-descriptions --disable-embed-rasters --strip-xml-space  --set-precision=${precisiondigitsN} --set-c-precision=${precisiondigits} --create-groups $META $INDENT --renderer-workaround --enable-id-stripping --disable-style-to-xml #--enable-viewboxing #--keep-unreferenced-defs #  

#--keep-unreferenced-defs
## if referenced-defs are deleted: https://github.com/scour-project/scour/issues/155
## error if keept: https://github.com/scour-project/scour/issues/156

#--enable-viewboxing
##Changes size of view
##can create Hairline-cracks f.e in https://commons.wikimedia.org/wiki/File:Mn_coa_zavkhan_aimag.svg

#--disable-style-to-xml #https://github.com/scour-project/scour/issues/176 #https://github.com/scour-project/scour/issues/174

#aktivated again (revert if wrong)
# --enable-id-stripping #https://github.com/scour-project/scour/issues/164

#--set-c-precision=5 #https://commons.wikimedia.org/wiki/File:Anatomy_of_Human_Ear_with_Cochlear_Frequency_Mapping.svg

# keep ID-Names: no #--shorten-ids and no # --enable-id-stripping
#--shorten-ids # https://github.com/scour-project/scour/issues/164
# --enable-id-stripping #https://github.com/scour-project/scour/issues/164

#echo mv ./${file} ./${tmp}3.xml
mv ./${file} ./${tmp}3.xml

echo scour $i finish

done

DeactivateAll=<<END

scour min.svg output.svg --disable-simplify-colors --disable-style-to-xml  --disable-group-collapsing --keep-editor-data --keep-unreferenced-defs --no-renderer-workaround --protect-ids-noninkscape --disable-embed-rasters

END

ActivateAll=<<END

scour min.svg output.svg --enable-comment-stripping --remove-titles --remove-descriptions --strip-xml-space  --create-groups --remove-metadata --remove-descriptive-elements --renderer-workaround  --enable-viewboxing --enable-id-stripping --shorten-ids 

END

