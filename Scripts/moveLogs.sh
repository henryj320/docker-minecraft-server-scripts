#!/bin/bash

container_name="minecraft-minecraft-1"
log_file_destination="/path/to/log/file/minecraft-server.log"

# Get the container ID from its name.
container_id=$(docker ps -q --filter "name=minecraft-minecraft-1")


if [ -z "$container_id" ]; then
    echo "Container not found."
	exit 1
else
    # Get the log path of the container
    log_path=$(docker inspect --format='{{.LogPath}}' "$container_id")
    
    if [ -z "$log_path" ]; then
        echo "Log path not found for container ID: $container_id"
		exit 1
    else
        echo "Log path for container ID $container_id: $log_path"

		# Copy the log file over to the shared area.
		cp "$log_path" "$log_file_destination"
    fi
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Minecraft server logs copied to $log_file_destination." >> "$log_file_location"

