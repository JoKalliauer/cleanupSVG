#!/bin/bash

export minfilesize=1 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape

chmod u+r *
#./svg2validsvg.sh
./Inkscape11BatchConverter.sh
./scour4compression.sh
./cleaner4compression.sh
./o4compression.sh

#./UngroupByInkscape.sh
#./ResizeByInkscape.sh
./Flow2TextByInkscape.sh

./ScourFull.sh
./ScourFull.sh
./CleanerFull.sh
#./cleaner4compression.sh
#./o4compression.sh
./OptimizerFull.sh
#./o4compression.sh

#./validBycleaner.sh
#./scour4compression.sh
./svg2validsvg.sh

for file in *.svg;do

# export file=min.svg
export tmp=$(echo $file | cut -f1 -d".")
export i=${tmp}C.svg
echo cleaner ${file} to $i begin
svgcleaner $file $i --apply-transform-to-gradients yes --apply-transform-to-shapes yes --convert-shapes yes --group-by-style yes --join-arcto-flags no --join-style-attributes some --merge-gradients yes --regroup-gradient-stops yes --remove-comments yes --remove-declarations yes --remove-default-attributes yes --remove-desc yes --remove-dupl-cmd-in-paths yes --remove-dupl-fegaussianblur yes --remove-dupl-lineargradient yes --remove-dupl-radialgradient yes --remove-gradient-attributes yes --remove-invalid-stops yes --remove-invisible-elements yes --remove-metadata yes --remove-needless-attributes yes --remove-nonsvg-attributes yes --remove-nonsvg-elements yes --remove-text-attributes yes --remove-title yes --remove-unreferenced-ids yes --remove-unresolved-classes yes --remove-unused-coordinates yes --remove-unused-defs yes --remove-version yes --remove-xmlns-xlink-attribute yes --resolve-use yes --simplify-transforms yes --trim-colors yes --trim-ids yes --trim-paths yes --ungroup-defs yes --ungroup-groups yes --use-implicit-cmds yes --list-separator comma --paths-to-relative yes --remove-unused-segments yes --convert-segments yes --apply-transform-to-paths yes --coordinates-precision 1 --paths-coordinates-precision 2 --properties-precision 1 --transforms-precision 2 --multipass --allow-bigger-file
mv ./${file} ./${tmp}N.xml


export file=$i


export tmp=$(echo $file | cut -f1 -d".")
export i=${tmp}O.svg
echo optizer ${file} to $i begin
svgo -i ${file} -o $i -p 2 --enable=cleanupAttrs --enable=cleanupEnableBackground --enable=cleanupIDs --enable=cleanupListOfValues --enable=cleanupNumericValues --enable=collapseGroups --enable=convertColors --disable=convertPathData --enable=convertShapeToPath --enable=convertStyleToAttrs --enable=convertTransform --enable=inlineStyles --enable=mergePaths --enable=minifyStyles --enable=moveElemsAttrsToGroup --enable=moveGroupAttrsToElems  --enable=removeAttrs --enable=removeComments --enable=removeDesc --enable=removeDimensions --enable=removeDoctype --enable=removeEditorsNSData --enable=removeEmptyAttrs --enable=removeEmptyContainers --enable=removeEmptyText --enable=removeHiddenElems --enable=removeMetadata --enable=removeNonInheritableGroupAttrs --enable=removeRasterImages --enable=removeScriptElement --enable=removeStyleElement --enable=removeTitle --enable=removeUnknownsAndDefaults --enable=removeUnusedNS --enable=removeUselessDefs --enable=removeUselessStrokeAndFill --enable=removeViewBox --enable=removeXMLProcInst --enable=sortAttrs --disable=removeXMLNS --multipass --enable=removeElementsByAttr
mv ./${file} ./${tmp}N.xml

export file=$i

export tmp=$(echo $file | cut -f1 -d".")
export i=${tmp}S.svg
echo scour ${file} to $i begin
scour -i ${file} -o $i --enable-comment-stripping --remove-titles --remove-descriptions --disable-embed-rasters --strip-xml-space  --create-groups --remove-metadata --remove-descriptive-elements --enable-id-stripping --shorten-ids --set-precision=3 --set-c-precision=2 --error-on-flowtext --no-line-breaks --indent=none # --no-renderer-workaround
mv ./${file} ./${tmp}N.xml

export file=$i


export tmp=$(echo $file | cut -f1 -d".")
export i=${tmp}O.svg
echo optizer ${file} to $i begin
svgo -i ${file} -o $i -p 2 --enable=cleanupAttrs --enable=cleanupEnableBackground --enable=cleanupIDs --enable=cleanupListOfValues --enable=cleanupNumericValues --enable=collapseGroups --enable=convertColors --enable=convertPathData --enable=convertShapeToPath --enable=convertStyleToAttrs --enable=convertTransform --enable=inlineStyles --enable=mergePaths --enable=minifyStyles --enable=moveElemsAttrsToGroup --enable=moveGroupAttrsToElems  --enable=removeAttrs --enable=removeComments --enable=removeDesc --enable=removeDimensions --enable=removeDoctype --enable=removeEditorsNSData --enable=removeEmptyAttrs --enable=removeEmptyContainers --enable=removeEmptyText --enable=removeHiddenElems --enable=removeMetadata --enable=removeNonInheritableGroupAttrs --enable=removeRasterImages --enable=removeScriptElement --enable=removeStyleElement --enable=removeTitle --enable=removeUnknownsAndDefaults --enable=removeUnusedNS --enable=removeUselessDefs --enable=removeUselessStrokeAndFill --enable=removeViewBox --enable=removeXMLProcInst --enable=sortAttrs --disable=removeXMLNS --multipass --enable=removeElementsByAttr
mv ./${file} ./${tmp}N.xml


done
