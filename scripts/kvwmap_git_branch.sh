#!/bin/bash
git_directory="/home/gisadmin/kvwmap-server"
if [ -d "$git_directory" ]; then
  cd ${git_directory} && git status | grep -i on | cut -d ' ' -f 3
else
   echo "'${git_directory}' directory is NOT exist"
fi
