#!/bin/bash

# Rocky Status webhook URL.
WEBHOOK_URL="https://discord.com/api/webhooks/<WEBHOOK-URL>"

already_notified_filepath="/path/to/directory/homepage_inaccessible.txt"
# Check if the file exists
if [ -e "$already_notified_filepath" ]; then
    echo "The file $already_notified_filepath already exists. Delete this file to resume script."
    exit 0
fi

# Exit if site is working.
if ping -q -c 1 -W 1 SERVER-URL >/dev/null; then
    echo "Server is functioning fine".
    exit 0
fi

# Check if the Minecraft docker container is running.
command_output=$(docker ps -q --filter "name=CONTAINER-NAME")
if [ -z "$command_output" ]; then
    # Message to send in the message.
    MESSAGE="Rocky Server is inaccessible and the Minecraft container is down."
else
    # Message to send in the message.
    MESSAGE="Rocky Server is inaccessible @The Angry Squid. The Minecraft container is still running though."
fi

# Construct the JSON payload.
JSON="{\"content\":\"$MESSAGE\"}"

# Use curl to send the POST request with the JSON payload.
curl -X POST -H "Content-Type: application/json" -d "$JSON" "$WEBHOOK_URL"

# Create the file so that the script will not re-run.
touch "$already_notified_filepath"
