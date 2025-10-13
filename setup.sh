#!/bin/bash

# Make users and group
# DO NOT USE 13001. That is used for immich on another server.
sudo useradd media -u 13000
sudo useradd radarr -u 13011
sudo useradd sonarr -u 13002
sudo useradd lidarr -u 13003
sudo useradd tautulli -u 13004
sudo useradd prowlarr -u 13005
sudo useradd bazarr -u 13006
sudo useradd qbittorrent -u 13007
sudo useradd sabnzbd -u 13012
sudo useradd overseerr -u 13009
sudo useradd notifiarr -u 13010
sudo groupadd mediacenter -g 13000


# Make directories
sudo mkdir -pv /home/$USER/docker-config

# Set permissions
sudo chmod -R 775 /home/$USER/docker-config
sudo chown -R $USER:mediacenter /home/$USER/docker-config
sudo usermod -aG mediacenter media
sudo usermod -aG mediacenter radarr
sudo usermod -aG mediacenter sonarr
sudo usermod -aG mediacenter lidarr
sudo usermod -aG mediacenter tautulli
sudo usermod -aG mediacenter prowlarr
sudo usermod -aG mediacenter bazarr
sudo usermod -aG mediacenter qbittorrent
sudo usermod -aG mediacenter sabnzbd
sudo usermod -aG mediacenter overseerr
sudo usermod -aG mediacenter notifiarr
sudo usermod -aG mediacenter $USER

echo "UID=$(id -u)" >> .env
