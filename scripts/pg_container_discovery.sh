#!/bin/bash
docker ps --filter "label=monitoring.pgmonitor=True" --format '{{.Names}}' | jq -R . | jq -s '{data: map({"PGCONTAINER": .})}'
