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
  sudo useradd mediacenter -M -u 13000
  sudo useradd radarr -M -u 13011
  sudo useradd sonarr -M -u 13002
  sudo useradd lidarr -M -u 13003
  sudo useradd tautulli -M -u 13004
  sudo useradd prowlarr -M -u 13005
  sudo useradd bazarr -M -u 13006
  sudo useradd qbittorrent -M -u 13007
  sudo useradd slskd -M -u 13008
  sudo useradd seerr -M -u 13009
  sudo useradd notifiarr -M -u 13010
  
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
  
  print_info "Users added to mediacenter group..."
}

# Set permissions
set_permissions() {
  sudo chmod -R 775 ${CONFIG_DIR}
  sudo chown -R mediacenter:mediacenter ${CONFIG_DIR}
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

  print_info "Permissions set..."
}

print_success "Done! It is recommended to reboot now."
