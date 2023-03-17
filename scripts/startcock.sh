#!/bin/bash
sudo cockroach start --insecure --store=/bfdata --listen-addr=0.0.0.0:26257 --http-addr=0.0.0.0:8080 --background --join=localhost:26257

URL="https://discord.com/api/webhooks/1072508325700325438/-e6yvrANyKDACFMWNFkb5IuanSeBJjQrb8i0h5RolJeiqG8QGf8JRcSLz6Bw4EUqhPY3"

JSON="{\"username\": \"DATABASE UPDATE\", \"content\": \":white_check_mark: Startet cockroach\"}"

curl -s -X POST -H "Content-Type: application/json" -d "$JSON" $URL
