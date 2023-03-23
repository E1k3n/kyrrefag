#!/bin/bash
sudo cockroach start --insecure --store=/bfdata --listen-addr=0.0.0.0:26257 --http-addr=0.0.0.0:8080 --background --join=localhost:26257

URL="https://discord.com/api/webhooks/1088458094431973396/x7Es73s0QDxHrqc3ilxNKveelvZ_nZs3Wgbm8SqdjntWKbGtjY-VW6GOOprEkhbGzyHU"

JSON="{\"username\": \"DATABASE UPDATE\", \"content\": \":white_check_mark: Startet cockroach\"}"

curl -s -X POST -H "Content-Type: application/json" -d "$JSON" $URL
