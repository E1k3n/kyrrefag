#!/bin/bash

// Finner antall brukere i bookface
cockroach --insecure --host=localhost sql --execute="USE bf; SELECT COUNT(*) FROM users;"