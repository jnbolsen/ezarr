#!/bin/bash

# Make users and group
sudo useradd radarr1 -u 13001
sudo useradd radarr2 -u 13002
sudo useradd sonarr -u 13003
sudo useradd lidarr -u 13004
sudo useradd readarr -u 13005
sudo useradd prowlarr -u 13006
sudo useradd bazarr1 -u 13007
sudo useradd bazarr2 -u 13008
sudo useradd qbittorrent -u 13009
sudo useradd overseerr -u 13010
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
sudo usermod -a -G mediacenter overseerr

# Make directories
sudo mkdir -pv docker/{radarr1,radarr2,sonarr,lidarr,readarr,prowlarr,bazarr1,bazarr2,qbittorrent,overseerr}-config
sudo mkdir -pv data/{usenet,torrents,media}/{series,movies,music,books}
# Need to mount network share to unraid or truenas VM

# Set permissions
sudo chmod -R 775 data/
sudo chown -R $(id -u):mediacenter data/
sudo chown -R radarr:mediacenter docker/radarr1-config
sudo chown -R radarr:mediacenter docker/radarr2-config
sudo chown -R sonarr:mediacenter docker/sonarr-config
sudo chown -R lidarr:mediacenter docker/lidarr-config
sudo chown -R readarr:mediacenter docker/readarr-config
sudo chown -R prowlarr:mediacenter docker/prowlarr-config
sudo chown -R radarr:mediacenter docker/bazarr1-config
sudo chown -R radarr:mediacenter docker/bazarr2-config
sudo chown -R qbittorrent:mediacenter docker/qbittorrent-config
sudo chown -R jackett:mediacenter docker/overseerr-config

echo "UID=$(id -u)" >> .env
