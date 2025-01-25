#!/bin/bash

container_name="minecraft-minecraft-1"

current_time=$(date +%s)
target_time=$(date -d "2025-02-17 12:00:00" +%s)

# Difference between current and target.
time_diff=$((target_time - current_time))

# If time already in past.
if [ $time_diff -lt 0 ]; then
  exit 0
else
  days=$((time_diff / 86400))
  hours=$(((time_diff % 86400) / 3600))

  echo "$days days and $hours hours away"
fi


output=$(echo "$(date "+%Y-%m-%d %H:%M:%S") - WARNING: Due to a house move, the server will temporarily be shut down in $days days and $hours hours.")
echo "$output"
docker exec $container_name mc-send-to-console say "[$(date '+%Y-%m-%d %H:%M:%S')] - WARNING: Due to a house move, the server will temporarily be shut down in $days days and $hours hours."
