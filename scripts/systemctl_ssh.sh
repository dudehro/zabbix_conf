#!/bin/bash

systemctlssh=$(systemctl status ssh | grep Active | awk '{print $2}')

if [[ "$systemctlssh" == "inactive" ]]
then
echo "SSH service is not running"
else
echo "SSH service is running"
fi

