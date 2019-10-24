#!/bin/sh
git config --global core.eol lf
git config core.eol lf
git pull
#git status
git add .
git status

read -n 1 -s -r -p "Press any key to continue"

git status
git commit -m "Update"
git status
git push
