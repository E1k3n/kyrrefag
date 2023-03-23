#!/bin/bash

message="$1"

URL="https://discord.com/api/webhooks/1088458094431973396/x7Es73s0QDxHrqc3ilxNKveelvZ_nZs3Wgbm8SqdjntWKbGtjY-VW6GOOprEkhbGzyHU"

USERNAME="Logger [$HOSTNAME]"

JSON="{\"username\": \"$USERNAME\", \"content\": \"$message\"}"

curl -s -X POST -H "Content-Type: application/json" -d "$JSON" $URL