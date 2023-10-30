#!/bin/bash

# Source path.
source_dir="/var/lib/docker/volumes/minecraft-data/_data/world-name"

# Destination path.
destination_dir="/path/to/target/directory/world-name"

log_file="/path/to/log/file/backup_logs.log"
current_date=$(date "+%Y-%m-%d %H:%M:%S")

# Process Started at.
start_time=$(date +%s)

# Size limit in GB (10GB).
size_limit=10

# Check if the source directory exists.
if [ -d "$source_dir" ]; then

    
    # Get the size of the source directory in GB. Converts size in kilobytes to GB.
    source_size_gb=$(du -s "$source_dir" | awk '{printf "%.1f", print $1/1024/1024}')

    # Fail if source is larger than $size_limit.
    if (( $(echo "$source_size_gb > $size_limit" | bc -l) )); then
        echo "$(date "+%Y-%m-%d %H:%M:%S") - Source directory is larger than $size_limit GB. Script will not run."
	echo "$(date "+%Y-%m-%d %H:%M:%S") - Source directory is larger than $size_limit GB. Script will not run." >> "$log_file"
        exit 1
    fi

    # Use rsync to copy and replace the entire directory.
    rsync -av --delete "$source_dir/" "$destination_dir"
    
    # Get the end time
    end_time=$(date +%s)


    # Calculate the duration in seconds
    duration_seconds=$((end_time - start_time))

    # Calculate the duration in minutes and seconds
    duration_minutes=$((duration_seconds / 60))
    duration_seconds=$((duration_seconds % 60))

    docker exec minecraft-minecraft-1 mc-send-to-console say "$(date "+%Y-%m-%d %H:%M:%S") - Backup to File Browser complete. (Duration: $duration_minutes minutes $duration_seconds seconds)"

    echo "$(date "+%Y-%m-%d %H:%M:%S") - Directory copied and previous backup overwritten successfully. (Duration: $duration_minutes minutes $duration_seconds seconds)"
    echo "$current_date - Directory copied and previous backup overwritten successfully. (Duration: $duration_minutes minutes $duration_seconds seconds)" >> "$log_file"
else


    # Calculate how long it took in seconds.
    end_time=$(date +%s)
    duration_seconds=$((end_time - start_time))

    # Convert to minutes and seconds.
    duration_minutes=$((duration_seconds / 60))
    duration_seconds=$((duration_seconds % 60))

    echo "$(date "+%Y-%m-%d %H:%M:%S") - Source directory does not exist."
    echo "$current_date - Source directory does not exist." >> "$log_file"
fi

