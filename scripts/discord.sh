#!/bin/bash

message="$1"

URL="DISCORD URL SKAL HIT"

USERNAME="Logger [$HOSTNAME]"

JSON="{\"username\": \"$USERNAME\", \"content\": \"$message\"}"

curl -s -X POST -H "Content-Type: application/json" -d "$JSON" $URL