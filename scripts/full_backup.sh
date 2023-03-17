#!/bin/bash

# Draining the database before stopping
sudo cockroach node drain 1 --insecure
# Check if drain is complete before continuing
while [[ $(sudo cockroach node ls --insecure --format=csv --host=localhost --certs-dir=/certs | grep "draining") ]]; do
  sleep 1s
done

# Stopping cockroachdb
cockroach quit --insecure --host=localhost

# Lag backup av bfdata-mappen
sudo cp -a /bfdata /bfdata_backup

# Start cockroachdb igjen
cockroach start --insecure --host=localhost --background

# Komprimer backupen
backup_name=$(date +"%Y-%m-%d-%H-%M-%S")_bfdata_backup.tar.gz
tar -czvf $backup_name /bfdata_backup

# Send backupen til remote serveren
echo "Sender backup til ubuntu@192.168.129.90:/home/ubuntu/backup/"
scp $backup_name ubuntu@192.168.129.90:/home/ubuntu/backup/