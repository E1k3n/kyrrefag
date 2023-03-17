#!/bin/bash

# Drainer databasen
sudo cockroach node drain 1 --insecure


# Shutdown prosessen
echo "Databasen er drained: Stopper databasen"

sudo pgrep cockroach | sudo xargs kill
wait 1;

# Tar kopi av /bfdata-mappen
sudo cp -r /bfdata/ ~/bfdata_backup
echo "Tar kopi av /bfdata"


# Starter CockroachDB igjen
sudo cockroach start --insecure --store=/bfdata --listen-addr=0.0.0.0:26257 --http-addr=0.0.0.0:8080 --background --join=localhost:26257

echo "Starter databasen"

# Lager et unikt navn til den komprimerte filen
komprimert=$(date +"%Y-%m-%d-%H-%M-%S")_bfdata_backup.tar.gz
echo "Navngir backupen"


# Komprimer /bfdata_backup-mappen med tar kommandoen
sudo tar -czvf $komprimert /bfdata_backup
echo "Komprimerer backupen"

# Kopier komprimert db1-kopi til backup maskinen med scp
sudo scp -i /home/ubuntu/.ssh/id_rsa $komprimert ubuntu@192.168.129.90:/home/ubuntu/backup/
echo "Overfører backup via scp"
