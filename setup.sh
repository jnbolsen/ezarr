#!/bin/bash

# Set up your .env file BEFORE running this script!!!

# Export all variables from environment variable file .env
set -a
source .env
set +a

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Print banner
print_banner() {
  echo -e "${BLUE}"
  echo "    ________  ___   ___  ___  "
  echo "   / __/_  / / _ | / _ \/ _ \ "
  echo "  / _/  / /_/ __ |/ , _/ , _/ "
  echo " /___/ /___/_/ |_/_/|_/_/|_|  "
  echo -e "${NC}"
  echo "Easily set up media arr stack"
  echo "=============================="
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
  
  print_info "Users and mediacenter group created..."
}

# Create config directories
# NFS data directories should be set up manually using fstab.
config_directories() {
  sudo mkdir -pv ${CONFIG_DIR}/{radarr,sonarr,lidarr,tautulli,prowlarr,bazarr,qbittorrent,qbitmanage,cross-seed,slskd,seerr,notifiarr}
  
  print_info "Configuration directories created..."
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
  
  print_info "Users added to mediacenter group..."
}

# Set permissions
set_permissions() {
  chmod -R 775 ${CONFIG_DIR}
  chown -R mediacenter:mediacenter ${CONFIG_DIR}
  chown -R radarr:radarr ${CONFIG_DIR}/radarr
  chown -R sonarr:sonarr ${CONFIG_DIR}/sonarr
  chown -R lidarr:lidarr ${CONFIG_DIR}/lidarr
  chown -R tautulli:tautulli ${CONFIG_DIR}/tautulli
  chown -R prowlarr:prowlarr ${CONFIG_DIR}/prowlarr
  chown -R bazarr:bazarr ${CONFIG_DIR}/bazarr
  chown -R qbittorrent:qbittorrent ${CONFIG_DIR}/qbittorrent
  chown -R qbittorrent:qbittorrent ${CONFIG_DIR}/qbitmanage
  chown -R qbittorrent:qbittorrent ${CONFIG_DIR}/cross-seed
  chown -R slskd:slskd ${CONFIG_DIR}/slskd
  chown -R seerr:seerr ${CONFIG_DIR}/seerr
  chown -R notifiarr:notifiarr ${CONFIG_DIR}/notifiarr

  print_info "Permissions set..."
}

print_success "Done! It is recommended to reboot now."
