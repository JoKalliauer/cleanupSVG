#!/bin/sh
git config --global core.eol lf
git config core.eol lf
git pull
#git status
git add .
git status

read -rsn1 -p"Press any key to continue" variable;echo

git status
git commit -m "Update"
git status
git push
