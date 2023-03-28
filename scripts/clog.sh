#!/bin/bash

# sjekk om jo er installert:

if ! which jo > /dev/null; then
echo "You need to have jo installed"
sudo apt install jo -y
exit 1
fi

# hvilken URL som skal brukes. tilpass dette:
URL="http://admin:ntnuwu@192.168.134.41:5984/clog"

# lag JSON
JSON=$( jo message="$1" date="$(date)" host=$HOSTNAME )

# send til databasen
curl -H "Content-Type: application/json" -X POST -d "$JSON" $URL
