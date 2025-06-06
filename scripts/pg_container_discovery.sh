#!/bin/bash
docker ps --filter "label=monitoring.pgmonitor=true" --format '{{.Names}}' | jq -R . | jq -s '{data: map({"PGCONTAINER": .})}'
