#!/bin/bash



servers=$(openstack server list -f csv | tail -n +2 | cut -d ',' -f 2 | xargs)

message=$servers

URL="https://discord.com/api/webhooks/1072508325700325438/-e6yvrANyKDACFMWNFkb5IuanSeBJjQrb8i0h5RolJeiqG8QGf8JRcSLz6Bw4EUqhPY3"

USERNAME="Logger [$HOSTNAME]"


JSON="{\"username\": \"$USERNAME\", \"content\": \"$message\"}"

curl -s -X POST -H "Content-Type: application/json" -d "$JSON" $URL



