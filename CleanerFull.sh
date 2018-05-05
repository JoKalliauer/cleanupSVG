#!/bin/bash

for file in *.svg;do
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=$(echo $fileN | cut -f1 -d".")
export i=${tmp}C.svg

echo #Add a empty line to split the output

echo cleaner ${file} to $i begin

svgcleaner $file $i  --allow-bigger-file --indent 1 --apply-transform-to-gradients yes --apply-transform-to-shapes yes --convert-shapes yes --group-by-style yes --join-arcto-flags yes --join-style-attributes no --merge-gradients yes --regroup-gradient-stops yes --remove-comments yes --remove-declarations no --remove-default-attributes yes --remove-desc yes --remove-dupl-cmd-in-paths yes --remove-dupl-fegaussianblur yes --remove-dupl-lineargradient yes --remove-dupl-radialgradient yes --remove-gradient-attributes yes --remove-invalid-stops yes --remove-invisible-elements yes --remove-metadata yes --remove-needless-attributes yes --remove-nonsvg-attributes yes --remove-nonsvg-elements yes --remove-text-attributes yes --remove-title yes --remove-unreferenced-ids yes --remove-unresolved-classes yes --remove-unused-coordinates yes --remove-unused-defs yes --remove-version yes --remove-xmlns-xlink-attribute yes --resolve-use yes --simplify-transforms yes --trim-colors yes --trim-ids yes --trim-paths yes --ungroup-defs yes --ungroup-groups yes --use-implicit-cmds yes --list-separator comma --paths-to-relative yes --convert-segments yes --apply-transform-to-paths yes --coordinates-precision 2 --paths-coordinates-precision 3 --properties-precision 2 --transforms-precision 4 --remove-unused-segments yes --multipass

#--properties-precision 2 # https://commons.wikimedia.org/wiki/File:Mn_coa_%C3%B6v%C3%B6rkhangai_aimag.svg
#--transforms-precision 4 # https://commons.wikimedia.org/wiki/File:Mn_coa_%C3%B6v%C3%B6rkhangai_aimag.svg
# --paths-coordinates-precision 3 # https://commons.wikimedia.org/wiki/File:Flag_of_Budapest_(1873-2011).svg

#--paths-to-relative no # https://github.com/RazrFalcon/svgcleaner/issues/124
# leads to --apply-transform-to-paths no
# and to --remove-unused-segments yes
# and to --convert-segments no

#--join-style-attributes no # I prefer font-size="20px" than style="font-size:20px;"

#--remove-declarations no #valid-warning

#--remove-nonsvg-elements  # removes flowtext

#debugging
#--join-arcto-flags no # https://commons.wikimedia.org/wiki/File:2016_Angola_and_DR_Congo_yellow_fever_outbreak.svg




#echo mv ./${file} ./${tmp}4.xml
mv ./${file} ./${tmp}4.xml

#echo cleaner $i finish

done

DeactivateEverything=<<END

svgcleaner.exe min.svg output.svg --allow-bigger-file --indent 1 --apply-transform-to-gradients no --apply-transform-to-shapes no --convert-segments no --convert-shapes no --group-by-style no --join-arcto-flags no --join-style-attributes no --merge-gradients no --regroup-gradient-stops no --remove-comments no --remove-declarations no --remove-default-attributes no --remove-desc no --remove-dupl-cmd-in-paths no --remove-dupl-fegaussianblur no --remove-dupl-lineargradient no --remove-dupl-radialgradient no --remove-gradient-attributes no --remove-invalid-stops no --remove-invisible-elements no --remove-metadata no --remove-needless-attributes no --remove-nonsvg-attributes no --remove-nonsvg-elements no --remove-text-attributes no --remove-title no --remove-unreferenced-ids no --remove-unresolved-classes no --remove-unused-coordinates no --remove-unused-defs no --remove-unused-segments no --paths-to-relative no --remove-version no --remove-xmlns-xlink-attribute no --resolve-use no --simplify-transforms no --trim-colors no --trim-ids no --trim-paths no --ungroup-defs no --ungroup-groups no --use-implicit-cmds no --apply-transform-to-paths no  # --copy-on-error

END

ActivateEverything=<<END


svgcleaner min.svg output.svg --allow-bigger-file --indent 1 --apply-transform-to-gradients yes --apply-transform-to-shapes yes --convert-shapes yes --group-by-style yes --join-arcto-flags yes --join-style-attributes all --merge-gradients yes --regroup-gradient-stops yes --remove-comments yes --remove-declarations yes --remove-default-attributes yes --remove-desc yes --remove-dupl-cmd-in-paths yes --remove-dupl-fegaussianblur yes --remove-dupl-lineargradient yes --remove-dupl-radialgradient yes --remove-gradient-attributes yes --remove-invalid-stops yes --remove-invisible-elements yes --remove-metadata yes --remove-needless-attributes yes --remove-nonsvg-attributes yes --remove-nonsvg-elements yes --remove-text-attributes yes --remove-title yes --remove-unreferenced-ids yes --remove-unresolved-classes yes --remove-unused-coordinates yes --remove-unused-defs yes --remove-version yes --remove-xmlns-xlink-attribute yes --resolve-use yes --simplify-transforms yes --trim-colors yes --trim-ids yes --trim-paths yes --ungroup-defs yes --ungroup-groups yes --use-implicit-cmds yes --list-separator comma --paths-to-relative yes --remove-unused-segments yes --convert-segments yes --apply-transform-to-paths yes

END

