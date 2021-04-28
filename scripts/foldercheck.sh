DIR="/home/gisadmin/docker/www/logs/apache2"

if [ -d "$DIR" ]; then
   echo "'$DIR' directory is exist"
else
   echo "'$DIR' directory is NOT exist"
fi

