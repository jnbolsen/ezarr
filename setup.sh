#!/bin/bash

# Make users and group
sudo useradd radarr1 -u 3001
sudo useradd radarr2 -u 3002
sudo useradd sonarr -u 3003
sudo useradd lidarr -u 3004
sudo useradd readarr -u 3005
sudo useradd prowlarr -u 3006
sudo useradd bazarr1 -u 3007
sudo useradd bazarr2 -u 3008
sudo useradd qbittorrent -u 3009
sudo useradd nzbget -u 3010
sudo useradd overseerr -u 3011
sudo groupadd mediacenter -g 13000
sudo usermod -a -G mediacenter radarr1
sudo usermod -a -G mediacenter radarr2
sudo usermod -a -G mediacenter sonarr
sudo usermod -a -G mediacenter lidarr
sudo usermod -a -G mediacenter readarr
sudo usermod -a -G mediacenter prowlarr
sudo usermod -a -G mediacenter bazarr1
sudo usermod -a -G mediacenter bazarr2
sudo usermod -a -G mediacenter qbittorrent
sudo usermod -a -G mediacenter nzbget
sudo usermod -a -G mediacenter overseerr

echo "UID=$(id -u)" >> .env
