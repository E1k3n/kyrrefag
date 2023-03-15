#!/bin/bash
source ./base.sh

# Finner antall brukere i bookface
brukere=$(cockroach --insecure --host=localhost sql --execute="USE bf; SELECT COUNT(*) FROM users;" \\
    | tail -n +3 | head -n 1 | awk '{print "Antall brukere\\t\\t" $1}')
info "$brukere"

# Finner antall poster i bookface
poster=$(cockroach --insecure --host=localhost sql --execute="USE bf; SELECT COUNT(*) FROM posts;" \\
    | tail -n +3 | head -n 1 | awk '{print "Antall poster\t\t" $1}')
info "$poster"

# Finner antall kommentarer i bookface
kommentarer=$(cockroach --insecure --host=localhost sql --execute="USE bf; SELECT COUNT(*) FROM comments;" \\
    | tail -n +3 | head -n 1 | awk '{print "Antall kommentarer\t" $1}')
info "$kommentarer"