#!/bin/bash

COMMAND="$1"

IPS=("192.168.131.189" "192.168.128.104" "192.168.128.173")

for IP in "${IPS[@]}"
do
  echo "Kjører kommandoen på  $IP"
  ssh ubuntu@$IP "$COMMAND"
done
