#!/bin/sh

#Author: Uktrunie, Xav, Johannes Kalliauer
#Source: http://www.inkscapeforum.com/viewtopic.php?t=12156#p45066
#Download date: 2018-05-10

#last Changes: (by Johannes Kalliauer)
#2018

for n in *.svg; do inkscape --file="$n" --with-gui --vacuum-defs --verb=EditSelectAll --verb=SelectionSimplify --verb=FileSave --verb=FileClose; done
