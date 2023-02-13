#!/bin/bash

./ResizeByInkscape.sh
./viewBoxS.sh 
./CleanerFull.sh
./OptimizerFull.sh
./ScourFull.sh
#sed -ri "s/ color-interpolation=\"auto\"//g;s/ color-interpolation=\"(s|linear)RGB\"//g;s/ color-rendering=\"(optimizeQuality|optimizeSpeed)\"//g;s/image-rendering=\"(optimizeQuality|optimizeSpeed)\"//g;s/ shape-rendering=\"crispEdges\"//g;s/ text-rendering=\"(geometricPrecision|optimizeSpeed)\"//g;s///g" $i 
./svg2validsvg.sh
./post.sh
