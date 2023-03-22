#!/bin/bash

COMMAND="$1"

IPS=("192.168.134.41" "192.168.129.228" "192.168.128.74")

for IP in "${IPS[@]}"
do
  echo "Kjører kommandoen på  $IP"
  ssh ubuntu@$IP "$COMMAND"
done
