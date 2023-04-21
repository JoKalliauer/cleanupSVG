#!/bin/bash

for file in *.svg
 do

 cp "${file}" "${file%.svg}.xml"

#only witespaced namespaces https://phabricator.wikimedia.org/source/mediawiki/browse/master/includes/upload/UploadBase.php$1592
sed -ri "s/  <d:SVGTestCase xmlns:d=\"http:\/\/www.w3.org\/2000\/02\/svg\/testsuite\/description\/\"/  <d:SVGTestCase xmlns:d=\"http:\/\/www.w3.org\/2000\/svg\" xmlnsd=\"http:\/\/www.w3.org\/2000\/02\/svg\/testsuite\/description\/\"/" $file
sed -ri "s/ xmlns=\"http:\/\/www.w3.org\/1999\/xhtml\"/ xmlnsDeactivated=\"http:\/\/www.w3.org\/1999\/xhtml\"/" $file
sed -ri  "s/ xmlns(|:bd)=\"http:\/\/(www.|)example.org\/[[[:alpha:]]*\"/ xmlns\1=\"http:\/\/www.inkscape.org\/namespaces\/inkscape\"/" $file

#do not refer something externally
sed -ri "s/[[:blank:]]xlink:href=\"data:(image\/svg\+xml|);base64,/ xlink:href=\"data:image\/jpeg;base64,/" $file
sed -ri "s/:href=(\"|')([[:lower:]\.]+)([-[:alnum:]\/\.#_:]*)(\"|')/href=\1\2\3\4/" $file
sed -ri "s/<(animate|set)([[:alpha:]=\"':# ]*) attributeName=(\"|')xlink:href(\"|')/<\1\2 attributeName=\3xlinkDeactivated\4/" $file
sed -ri "s/<set([[:alpha:] =\"]*) xlink:href=/<set\1 xlinkDeactivated=/" $file
#sed -ri "s/<set([[:alnum:]=\" :#]*) to=\"([-[:alnum:]\.\/#;\+,:]*)\"/<setDeactivated\1 toDeactivated=\"\2\"/" $file
sed -ri "s/<(d:testDescription) ([[:alnum:]:\"=\/. ]*)href=\"([[htp\.\/]]*)/<\1 \2hrefDeactivated=\"\3/" $file
sed -ri "s/ xlink:href=\"url\(\#([[:alpha:]]*)\)\"/ xlink:href=\"\#\1\"/" $file

sed -ri "s/ @import / import /" $file
sed -ri "s/ url\(([[:lower:]\.\/\"]*)([-[:alnum:]\/\.#\"]*)\)/ urlDeactivated\(\1\2\)/" $file

# onclick="evt.currentTarget.correspondingElement.style.fill='blue';"
#src: url(woffs/embeded-text-text-04.woff)
#deactivate scripts
sed -ri "s/<script/<Deactivatedscript/" $file
sed -ri "s/<\/script>/<\/Deactivatedscript>/" $file
sed -ri "s/[[:blank:]]on([[:lower:]]+)=(\"|')([[:alpha:]]+[[:alnum:]_,' \(\)\.#;]*)/ deactivatedon\1=\2\3/g" $file

mv "${file}" "${file%.svg}.svg"

done

