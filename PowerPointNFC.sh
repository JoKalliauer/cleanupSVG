#!/bin/bash


for file in *.svg;do

# export file=min.svg
export tmp=$(echo $file | cut -f1 -d".")
echo cleaner ${file} begin
mv ./${file} ./${tmp}P.svg
svgcleaner ${tmp}P.svg ${tmp}.svg --apply-transform-to-gradients yes --apply-transform-to-shapes yes --convert-shapes yes --group-by-style yes --join-arcto-flags no --join-style-attributes some --merge-gradients yes --regroup-gradient-stops yes --remove-comments yes --remove-declarations yes --remove-default-attributes yes --remove-desc yes --remove-dupl-cmd-in-paths yes --remove-dupl-fegaussianblur yes --remove-dupl-lineargradient yes --remove-dupl-radialgradient yes --remove-gradient-attributes yes --remove-invalid-stops yes --remove-invisible-elements yes --remove-metadata yes --remove-needless-attributes yes --remove-nonsvg-attributes yes --remove-nonsvg-elements yes --remove-text-attributes yes --remove-title yes --remove-unreferenced-ids yes --remove-unresolved-classes yes --remove-unused-coordinates yes --remove-unused-defs yes --remove-version yes --remove-xmlns-xlink-attribute yes --resolve-use yes --simplify-transforms yes --trim-colors yes --trim-ids yes --trim-paths yes --ungroup-defs yes --ungroup-groups yes --use-implicit-cmds yes --list-separator comma --paths-to-relative yes --remove-unused-segments yes --convert-segments yes --apply-transform-to-paths yes --coordinates-precision 1 --paths-coordinates-precision 2 --properties-precision 1 --transforms-precision 4 --multipass
mv  ./${tmp}P.svg ./${tmp}P.xml

done
