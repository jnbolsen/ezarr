#!/bin/bash

# Set up your .env file BEFORE running this script!!!

# Export all variables from environment variable file .env
set -a
source .env
set +a

# Make users and groups
# DO NOT USE 13001. That is used for immich on another server.
# User media is mapped to my NAS.
sudo groupadd mediacenter -g 13000
sudo useradd media -u 13000 -g mediacenter
sudo useradd radarr -u 13011
sudo useradd sonarr -u 13002
sudo useradd lidarr -u 13003
sudo useradd tautulli -u 13004
sudo useradd prowlarr -u 13005
sudo useradd bazarr -u 13006
sudo useradd qbittorrent -u 13007
sudo useradd slskd -u 13008
sudo useradd seerr -u 13009
sudo useradd notifiarr -u 13010

# Make config directory
# NFS data directories should be set up manually.
sudo mkdir -pv ${CONFIG_DIR}

# Add users to mediacenter group
sudo usermod -aG mediacenter radarr
sudo usermod -aG mediacenter sonarr
sudo usermod -aG mediacenter lidarr
sudo usermod -aG mediacenter tautulli
sudo usermod -aG mediacenter prowlarr
sudo usermod -aG mediacenter bazarr
sudo usermod -aG mediacenter qbittorrent
sudo usermod -aG mediacenter slskd
sudo usermod -aG mediacenter seerr
sudo usermod -aG mediacenter notifiarr
sudo usermod -aG mediacenter $USER

# Make directories
sudo mkdir -pv ${CONFIG_DIR}/{radarr,sonarr,lidarr,tautulli,prowlarr,bazarr,qbittorrent,qbitmanage,cross-seed,slskd,seerr,notifiarr}
# Set permissions
sudo chmod -R 775 ${CONFIG_DIR}
sudo chown -R media:mediacenter ${CONFIG_DIR}
sudo chown -R radarr:mediacenter ${CONFIG_DIR}/radarr
sudo chown -R sonarr:mediacenter ${CONFIG_DIR}/sonarr
sudo chown -R lidarr:mediacenter ${CONFIG_DIR}/lidarr
sudo chown -R tautulli:mediacenter ${CONFIG_DIR}/tautulli
sudo chown -R prowlarr:mediacenter ${CONFIG_DIR}/prowlarr
sudo chown -R bazarr:mediacenter ${CONFIG_DIR}/bazarr
sudo chown -R qbittorrent:mediacenter ${CONFIG_DIR}/qbittorrent
sudo chown -R qbittorrent:mediacenter ${CONFIG_DIR}/qbitmanage
sudo chown -R qbittorrent:mediacenter ${CONFIG_DIR}/cross-seed
sudo chown -R slskd:mediacenter ${CONFIG_DIR}/slskd
sudo chown -R overseerr:mediacenter ${CONFIG_DIR}/seerr
sudo chown -R notifiarr:mediacenter ${CONFIG_DIR}/notifiarr

echo "Done! It is recommended to reboot now."
