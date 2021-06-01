#!/bin/bash

systemctl=$(systemctl status docker | grep Active | awk '{print $2}')

if [[ "$systemctl" == "inactive" ]]
then
echo "Docker service is not running"
else
echo "Docker service is running"
fi

