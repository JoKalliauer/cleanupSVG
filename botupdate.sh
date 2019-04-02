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

ln -s /data/project/svgworkaroundbot/user-config.py  /data/project/svgworkaroundbot/SVGWorkaroundBot/cleanupSVG-master/user-config.py 
ln -s /data/project/svgworkaroundbot/user-password.py  /data/project/svgworkaroundbot/SVGWorkaroundBot/cleanupSVG-master/user-password.py 

cp /data/project/svgworkaroundbot/SVGWorkaroundBot/cleanupSVG-master/botupdate.sh ./botupdate.sh
