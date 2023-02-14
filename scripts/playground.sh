#!/bin/bash

servers=$(openstack server list -f csv | tail -n +2 | cut -d ',' -f 2 | xargs)

echo "$servers"
