#!/bin/bash

container_name="minecraft-minecraft-1"
log_file_location="/path/to/log/file/resources.log"
sleep_time=60

docker exec $container_name mc-send-to-console say "Server is restarting in $sleep_time seconds."

sleep $sleep_time

cd /path/to/docker/compose

for ((i=3; i>0; i--))
do
	docker exec $container_name mc-send-to-console say "Server is restarting in $i..."
	sleep 1
done

echo "$(date '+%Y-%m-%d %H:%M:%S') - Server automatically restarting." >> "$log_file_location"

docker compose down

docker compose up -d 

