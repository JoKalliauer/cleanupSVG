#!/bin/bash

rm master.zip

wget https://github.com/JoKalliauer/cleanupSVG/archive/master.zip

unzip -zo master.zip

chmod a+x cleanupSVG-master/WorkaroundBotsvg2validsvg.sh

cd /data/project/svgworkaroundbot/SVGWorkaroundBot/cleanupSVG-master/

chmod a+x *.sh

cd ..
