#!/bin/bash

URL="https://discord.com/api/webhooks/1072508325700325438/-e6yvrANyKDACFMWNFkb5IuanSeBJjQrb8i0h5RolJeiqG8QGf8JRcSLz6Bw4EUqhPY3"


all_server_id=$(openstack server list -f csv | tail -n +2 | cut -d ',' -f 1 | tr '\n' ' ' | tr -d '"');


for server in $all_server_id;
do
        #Uncomment for å debugge
        #openstack server show "$server" -f value -c status

        status=$(openstack server show "$server" -f value -c status);
	name=$(openstack server show "$server" -f value -c name);
	
	#Sender til discord
	JSON="{\"username\": \"STATUS UPDATE on // $name //\", \"content\": \"$status\"}"
	curl -s -X POST -H "Content-Type: application/json" -d "$JSON" $URL
done



#JSON="{\"username\": \"$USERNAME\", \"content\": \"$message\"}"
#curl -s -X POST -H "Content-Type: application/json" -d "$JSON" $URL



