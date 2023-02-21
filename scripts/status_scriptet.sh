#!/bin/bash
#Author: Fredrik Stenersen

#For discord web hook
URL="https://discord.com/api/webhooks/1072508325700325438/-e6yvrANyKDACFMWNFkb5IuanSeBJjQrb8i0h5RolJeiqG8QGf8JRcSLz6Bw4EUqhPY3"
date_now=$(date)

#Henter server ID fra samtlige servere
all_server_id=$(openstack server list -f csv | tail -n +2 | cut -d ',' -f 1 | tr '\n' ' ' | tr -d '"');


for server in $all_server_id;
do
        #Uncomment for å debugge
        #openstack server show "$server" -f value -c name -c status

        status=$(openstack server show "$server" -f value -c status);
	name=$(openstack server show "$server" -f value -c name);

	
	#Sjekk på status (www1 og www2 er hardkodet ut siden de kjøres i docker)
	if [[ $status != "ACTIVE" && $name != "www1" && $name != "www2" ]];
	then	
		#Sender til discord
		JSON="{\"username\": \"STATUS UPDATE on // $name //\", \"content\": \":warning: @everyone        $date_now           Status: :x:  $status\"}"
        	curl -s -X POST -H "Content-Type: application/json" -d "$JSON" $URL

		#Rebooter serveren om den er nede
		nova start $name;
	

		#Send status etter forsøkt reboot
		while [[ $status != "ACTIVE"  ]]
		do	

        		status=$(openstack server show "$server" -f value -c status);
			JSON="{\"username\": \"STATUS UPDATE on // $name //\", \"content\": \":repeat: Forsøkte å starte maskinen. Status nå:  $status\"}"
        		curl -s -X POST -H "Content-Type: application/json" -d "$JSON" $URL
			sleep 2;
		done
		
		if [[ $status == "ACTIVE"  ]]
                then 
			status=$(openstack server show "$server" -f value -c status);
                        JSON="{\"username\": \"STATUS UPDATE on // $name //\", \"content\": \":eight_spoked_asterisk: Forsøkte å starte maskinen. Status nå:  $status\"}"
                        curl -s -X POST -H "Content-Type: application/json" -d "$JSON" $URL
	
		fi
	fi
done

#Her bare bekrefter den at scriptet er kjør - sender til logfil
#TODO pr nå sendes kun kvittering til logfilen, serverstatus sendes ikke
echo "Fullførte status_scriptet.sh på $date_now" >> status_log.txt;
