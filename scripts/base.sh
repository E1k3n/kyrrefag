# Paste URL below
URL=""

discord_log () {

message="$1"

USERNAME="Logger [$HOSTNAME] ${0##*/}"

JSON="{\"username\": \"$USERNAME\", \"content\": \"$message\"}"

curl -s -X POST -H "Content-Type: application/json" -d "$JSON" $URL

}