#!/bin/bash

function get_pgsql_container(){
	while read IMAGE
	do
		docker ps -a --quiet --filter ancestor=pkorduan/postgis:$IMAGE
	done < <(get_postgis_image_tags)
}

function get_postgis_image_tags(){
	next=https://registry.hub.docker.com/v2/repositories/pkorduan/postgis/tags/?page=1
	while [ "$next" != "null" ]
	do
		curl $next 2> /dev/null | jq -r '."results"[]["name"]'
		next=$(curl "$next" 2> /dev/null | jq -r '.["next"]' )
	done
}

case $1 in
	list_pgsql_container)
		get_pgsql_container
	;;
esac
