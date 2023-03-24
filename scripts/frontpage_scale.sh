#!/bin/bash

# Name of company
COMPANY_NAME="NTNuWu"

# IP address of server 1 or whoever is the docker swarm leader
SERVER_IP="192.168.134.41"

# What is the lowest desired number of frontpage users?
FRONTPAGE_COUNT_LIMIT=500

# What increments do we increase in?
SCALE_UP_INCREMENT=25

# What increments do we decrease in?
SCALE_DOWN_INCREMENT=50

# What is the lower download time limit we would like to stay above?
DOWNLOAD_TIME_LOWER_THRESHOLD=4.5

# What is the upper download time limit we would like to stay below?
DOWNLOAD_TIME_UPPER_THRESHOLD=5.5

# SAFETY VALVE: Set this to "0" if you want the scaling to actually take place
SAFETY_VALVE=1

########################
# SAFETY CHECK: Is bc installed?

if ! which bc > /dev/null; then
echo "You need to install the package 'bc' first"
exit 1
fi

########################
# Define function for scaling

function scale {

# This script is assumed to run on the manager and SSH to a server
# in order to run the docker service upgrade command.
# we also assume that we need to use sudo.

COMMAND="sudo docker service update --env-add BF_FRONTPAGE_LIMIT=$1 bf_web"

# This could be improved, because what happens when server 1 is unavailable?

SSH_COMMAND="ssh -t ubuntu@$SERVER_IP "

if [ "$SAFETY_VALVE" -eq "0" ]; then
# Safety valve is off, we're running the command
$SSH_COMMAND $COMMAND

else
# Saftey valve is on, we only print what we would do
echo "Safety valve is on, this is what would be executed: "
echo $SSH_COMMAND $COMMAND

fi

}

################################
# Check if the site is up. Exit if it's down.

STATUS=$( curl -s -g 'http://admin:admin@192.168.132.61:9090/api/v1/query?query=last_status{name="'$COMPANY_NAME'"}' | jq -r '.data.result[].value[1] ')

if [ "$STATUS" -gt "0" ]; then
echo "Site is considered up"
else
echo "Site is considered down, we should stop here"
exit 1
fi

################################
# The site is up, so we can proceed with checking its performance

# Get current download times:

DOWNLOAD_TIME=$( curl -s -g 'http://admin:admin@192.168.132.61:9090/api/v1/query?query=last_download_time{name="'$COMPANY_NAME'"}' | jq -r '.data.result[].value[1] ')

NUMBER_OF_FRONTPAGE_USERS=$( curl -s -g 'http://admin:admin@192.168.132.61:9090/api/v1/query?query=frontpage_count{name="'$COMPANY_NAME'"}' | jq -r '.data.result[].value[1] ')

echo "Observed download time: $DOWNLOAD_TIME"

# check if we are below the lower threshold. If we are, we scale up
if (( $(echo "$DOWNLOAD_TIME < $DOWNLOAD_TIME_LOWER_THRESHOLD" | bc -l) )); then

NEW_FRONTPAGE_COUNT=$( echo "$NUMBER_OF_FRONTPAGE_USERS + $SCALE_UP_INCREMENT" | bc )

echo "Download time was lower, we have some capacity to spare. Scaling up to $NEW_FRONTPAGE_COUNT"

scale $NEW_FRONTPAGE_COUNT

# check if we are above the higher threshold. If we are, scale down, but not lower than the limit
elif (( $(echo "$DOWNLOAD_TIME > $DOWNLOAD_TIME_UPPER_THRESHOLD" | bc -l) )); then

# We can't go lower than the bottom
if [ "$NUMBER_OF_FRONTPAGE_USERS" -eq "$FRONTPAGE_COUNT_LIMIT" ]; then

echo "We should go lower, but we are already at the limit"

exit 0

fi

# Lowering the number of frontpage users
NEW_FRONTPAGE_COUNT=$( echo "$NUMBER_OF_FRONTPAGE_USERS - $SCALE_DOWN_INCREMENT" | bc )

if [ "$NEW_FRONTPAGE_COUNT" -lt "$FRONTPAGE_COUNT_LIMIT" ]; then

echo "We should scale down, but can't go lower then the limit, so we end up at $FRONTPAGE_COUNT_LIMIT"

NEW_FRONTPAGE_COUNT=$FRONTPAGE_COUNT_LIMIT

else

echo "Scaling down to $NEW_FRONTPAGE_COUNT as new frontpage_limit"
scale $NEW_FRONTPAGE_COUNT

fi

fi