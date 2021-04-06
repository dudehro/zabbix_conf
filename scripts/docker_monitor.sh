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

function docker_ps_pgsql_container(){
	while read TAG
	do
		DOCKERPS=$(docker ps -a --format "{{.Image}}\t{{.Names}}\t{{.Status}}\t{{.Networks}}" --filter ancestor=pkorduan/postgis:$TAG)
		if [[ -n $DOCKERPS ]]; then
			echo $DOCKERPS
		fi
	done < <(get_postgis_image_tags)
}

function get_pgsql_versions(){
        while read TAG
        do
                DOCKERPS=$(docker ps -a --format "{{.Names}}" --filter ancestor=pkorduan/postgis:$TAG)
                if [[ -n $DOCKERPS ]]; then
                        echo $TAG
                fi
        done < <(get_postgis_image_tags)
}

case $1 in
	list-postgis-image-tags)
		get_postgis_image_tags
	;;
	list-pgsql-container-ids)
		get_pgsql_container
	;;
	docker-ps-pgsql)
		docker_ps_pgsql_container
	;;
	list-pgsql-versions)
		get_pgsql_versions
	;;
esac
