#!/bin/bash

# Finner antall brukere i bookface
cockroach --insecure --host=localhost sql --execute="USE bf; SELECT COUNT(*) FROM users;"  | tail -n +3 | head -n 1 | awk '{print "Antall brukere\t\t" $1}'

# Finner antall poster i bookface
cockroach --insecure --host=localhost sql --execute="USE bf; SELECT COUNT(*) FROM posts;" | tail -n +3 | head -n 1 | awk '{print "Antall poster\t\t" $1}'

# Finner antall kommentarer i bookface
cockroach --insecure --host=localhost sql --execute="USE bf; SELECT COUNT(*) FROM comments;" | tail -n +3 | head -n 1 | awk '{print "Antall kommentarer\t" $1}'