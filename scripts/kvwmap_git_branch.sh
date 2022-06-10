#!/bin/bash

git_directory="/home/gisadmin/kvwmap-server"

if [ -d "$git_directory" ]; then
  cd ${git_directory}; git rev-parse --abbrev-ref HEAD
else
   echo "'${git_directory}' directory is NOT exist"
fi
