#!/bin/sh
git config --global core.eol lf
git config core.eol lf
git pull
#git status
git add .
git status
read -p "Press enter to continue" -n1 -s #Press Control C for stop
git status
git commit -m "Update"
git status
git push
