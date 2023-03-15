#!/bin/bash
source ./base.sh

ls "$1"

if [ $? -eq 0 ]; then
    ok "Denne mappen eksisterer!"
else
    error "Denne mappen eksisterer IKKE!"
fi