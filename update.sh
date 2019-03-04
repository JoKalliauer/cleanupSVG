#!/bin/bash

rm master.zip

wget https://github.com/JoKalliauer/cleanupSVG/archive/master.zip

unzip -o master.zip

chmod a+x cleanupSVG-master/WorkaroundBotsvg2validsvg.sh
