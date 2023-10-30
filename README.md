 # docker-minecraft-server-scripts
 
Last update: 2023-10-30 10:47
<br><br>

## docker-minecraft-server-scripts

**Title**: docker-minecraft-server-scripts

**Date Started**: 2023-10-30

**Language**: Bash

**Overview**: A collection of Bash scripts to use on the dockerised Minecraft server.

---

## Running each Script

### Requirements

You will need to be running a Minecraft server inside of a Docker container. In order to best do this, I suggest using: https://github.com/itzg/docker-minecraft-server. As of October 2023, this repository is still being worked on.

For the Bash scripts to work, the server must be running on a Linux-based system. These Bash scripts have not been tested within Windows or MacOS.

### Preparing the Scripts

For each Bash script, there are global variables at the head of the script that need to be updated. These relate to the location of log files, delays and Docker container names. Edit the names.

### Running the Scripts

After adapting the scripts, copy the Bash scripts onto the machine running the Docker containers. You will need to make the scripts executable by running ` chmod +x script-name.sh `. At this point, you can run the script one-off by ` cd ` into the directory with the script and performing ` sudo ./script-name.sh `.

If you would like to run the scripts at a regular interval, then you need to set up a cron job. This, for example, would allow the server to be backed up every night or for the resources used on the server to be printed hourly. To do this, run the following lines:

```bash
sudo su root  # Switch to the root user.

crontab -e  # Opens the cronjobs file.
0 2 * * * /path/to/script/script-name.sh
```

The example cron job above will run *script-name.sh* every night at 2AM. To learn how to specify certain times in cron jobs, refer to: https://crontab.cronhub.io/.
