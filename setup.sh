#!/bin/bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
msg_info() { echo -e "${NC}INFO:${NC} $1"; }
msg_ok() { echo -e "${GREEN}SUCCESS:${NC} $1"; }
msg_error() { echo -e "${RED}ERROR:${NC} $1" >&2; }

# Logging setup
LOGFILE="/var/log/ezarr.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Print banner
print_banner() {
  echo -e "${BLUE}"
  echo "    ________  ___   ___  ___  "
  echo "   / __/_  / / _ | / _ \/ _ \ "
  echo "  / _/  / /_/ __ |/ , _/ , _/ "
  echo " /___/ /___/_/ |_/_/|_/_/|_|  "
  echo "=============================="
  echo -e "${NC}"
  echo "Setting up media arr stack..."
  echo ""
}

# Create users
# DO NOT USE 13001. That is used for immich on another server.
# User mediacenter and group mediacenter is mapped to my NAS with permissions set.
create_users() {
  useradd mediacenter -M -u 13000
  useradd radarr -M -u 13011
  useradd sonarr -M -u 13002
  useradd lidarr -M -u 13003
  useradd tautulli -M -u 13004
  useradd prowlarr -M -u 13005
  useradd bazarr -M -u 13006
  useradd qbittorrent -M -u 13007
  useradd slskd -M -u 13008
  useradd seerr -M -u 13009
  useradd notifiarr -M -u 13010
  
  msg_info "Users and mediacenter group created."
}

# Create config directories
# NFS data directories should be set up manually using fstab.
config_directories() {
  sudo mkdir -pv ${CONFIG_DIR}/{radarr,sonarr,lidarr,tautulli,prowlarr,bazarr,qbittorrent,qbitmanage,cross-seed,slskd,seerr,notifiarr}
  
  msg_info "Configuration directories created."
}

# Add users to mediacenter group
add_users() {
  usermod -aG mediacenter radarr
  usermod -aG mediacenter sonarr
  usermod -aG mediacenter lidarr
  usermod -aG mediacenter tautulli
  usermod -aG mediacenter prowlarr
  usermod -aG mediacenter bazarr
  usermod -aG mediacenter qbittorrent
  usermod -aG mediacenter slskd
  usermod -aG mediacenter seerr
  usermod -aG mediacenter notifiarr
  
  msg_info "Users added to mediacenter group."
}

# Set permissions
set_permissions() {
  chmod -R 775 ${CONFIG_DIR}
  chown mediacenter:mediacenter ${CONFIG_DIR}
  chown radarr:radarr ${CONFIG_DIR}/radarr
  chown sonarr:sonarr ${CONFIG_DIR}/sonarr
  chown lidarr:lidarr ${CONFIG_DIR}/lidarr
  chown tautulli:tautulli ${CONFIG_DIR}/tautulli
  chown prowlarr:prowlarr ${CONFIG_DIR}/prowlarr
  chown bazarr:bazarr ${CONFIG_DIR}/bazarr
  chown qbittorrent:qbittorrent ${CONFIG_DIR}/qbittorrent
  chown qbittorrent:qbittorrent ${CONFIG_DIR}/qbitmanage
  chown qbittorrent:qbittorrent ${CONFIG_DIR}/cross-seed
  chown slskd:slskd ${CONFIG_DIR}/slskd
  chown seerr:seerr ${CONFIG_DIR}/seerr
  chown notifiarr:notifiarr ${CONFIG_DIR}/notifiarr

  msg_info "Permissions set."
}

msg_ok "Done! It is recommended to reboot now."
