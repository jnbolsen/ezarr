#!/bin/bash

# Make users and group
sudo useradd radarr -u 13011
sudo useradd sonarr -u 13002
sudo useradd lidarr -u 13003
sudo useradd readarr -u 13004
sudo useradd prowlarr -u 13005
sudo useradd bazarr -u 13006
sudo useradd qbittorrent -u 13007
sudo useradd nzbget -u 13008
sudo useradd overseerr -u 13009
sudo useradd notifiarr -u 13010
sudo groupadd mediacenter -g 13000


# Make directories
sudo mkdir -pv /docker-config

# Set permissions
sudo chmod -R 775 /docker-config
sudo chown -R $(id -u):mediacenter /docker-config
sudo usermod -aG mediacenter radarr
sudo usermod -aG mediacenter sonarr
sudo usermod -aG mediacenter lidarr
sudo usermod -aG mediacenter readarr
sudo usermod -aG mediacenter prowlarr
sudo usermod -aG mediacenter bazarr
sudo usermod -aG mediacenter qbittorrent
sudo usermod -aG mediacenter nzbget
sudo usermod -aG mediacenter overseerr
sudo usermod -aG mediacenter notifiarr

echo "UID=$(id -u)" >> .env
