#!/bin/sh
git config --global core.eol lf
git config core.eol lf
#git status
git add .
git status
read -p "Press enter to continue" #Press Control C for stop
git status
git commit -m "Update"
git status
git push
