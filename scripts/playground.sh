#!/bin/bash

all_server_id=$(openstack server list -f csv | tail -n +2 | cut -d ',' -f 1 | tr '\n' ' ' | tr -d '"');


for server in $all_server_id;
do
	#Uncomment for å debugge
	#openstack server show "$server" -f value -c statusi

	status=$(openstack server show "$server" -f value -c status);
	


done
	



