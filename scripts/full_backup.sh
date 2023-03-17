#!/bin/bash

# Tømmer databasen før stopp
sudo cockroach node drain 1 --insecure
# Sjekker om tømming er fullført før fortsettelse
while [[ $(sudo cockroach node ls --insecure --format=csv --host=localhost --certs-dir=/certs | grep "draining") ]]; do
  sleep 1s
done

# Stopper cockroachdb
# Få prosess-IDen til prosessen du vil drepe
pid=$(pgrep cockroach)

# Sjekk om prosessen kjører
if ps -p $pid > /dev/null; then
  # Hvis prosessen kjører, killes den
  sudo kill $pid

  # Vent til prosessen slutter å kjøre
  while ps -p $pid > /dev/null; do
    sleep 1s
  done
fi

# Lag backup av bfdata-mappen
sudo cp -a /bfdata /bfdata_backup

# Starter cockroachdb igjen
sudo cockroach start --insecure --store=/bfdata --listen-addr=0.0.0.0:26257 --http-addr=0.0.0.0:8080 --background --join=localhost:26257

# Komprimer backupen
backup_navn=$(date +"%Y-%m-%d-%H-%M-%S")_bfdata_backup.tar.gz
tar -czvf $backup_navn /bfdata_backup

# Sender backupen til remote serveren
echo "Sender backupen til ubuntu@192.168.129.90:/home/ubuntu/backup/"
sudo scp -i /home/ubuntu/.ssh/id_rsa $komprimert ubuntu@192.168.129.90:/home/ubuntu/backup/