#!/bin/bash

container_name="minecraft-minecraft-1"
# Source path.
world_file_location="/var/lib/docker/volumes/minecraft-data/_data/world-name"

log_file_location="/path/to/log/file/resources.log"

# Holds the container details for the Minecraft server.
container_stats=$(docker stats --no-stream --format "table {{.Name}}\t{{.ID}}\t{{.CPUPerc}}\t{{.MemUsage}}" | grep "$container_name")

# Gets the CPU usage by extracting the 3rd word in container_stats.
cpu_usage=$(echo "$container_stats" | awk '{print $3}')

memory_usage=$(echo "$container_stats" | awk '{print $4}')
converted_memory_usage=$(echo "$memory_usage" | grep -o -E '[0-9.]+')
# Rounds and shortens the memory usage to 1 decimal point.
converted_memory_usage=$(printf "%.1f" $converted_memory_usage)

# Returns the file size in GB.
file_size=$(du -s "$world_file_location" | awk '{print $1/1024/1024}')
# file_size=$((file_size / 1024 / 1024))
file_size=$(printf "%.1f" $file_size)

output=$(echo "$(date "+%Y-%m-%d %H:%M:%S") - CPU: $cpu_usage. Memory: $converted_memory_usage GB out of 24 GB. World Size: $file_size GB.")

echo "$output"

if [ "$(date '+%H')" == "03" ] || [ "$(date '+%H')" == "22" ]; then
    echo "$output" >> "$log_file_location"
else
    echo "Output not sent to log file."
fi

docker exec $container_name mc-send-to-console say "[$(date '+%Y-%m-%d %H:%M:%S')] Hourly Resource Checkup - CPU: $cpu_usage. Memory: $converted_memory_usage GB out of 24 GB. World Size: $file_size GB."
