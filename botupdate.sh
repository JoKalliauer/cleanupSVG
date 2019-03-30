#!/bin/bash

# That has just internal usage for JoKalliauer, please ignore this file

rm master.zip

rmdir --ignore-fail-on-non-empty ./cleanupSVG-master/

wget https://github.com/JoKalliauer/cleanupSVG/archive/master.zip

unzip -zo master.zip

chmod a+x cleanupSVG-master/WorkaroundBotsvg2validsvg.sh

cd /data/project/svgworkaroundbot/SVGWorkaroundBot/cleanupSVG-master/

chmod a+x *.sh

cd ..

cp /data/project/svgworkaroundbot/SVGWorkaroundBot/cleanupSVG-master/update.sh ./update.sh
