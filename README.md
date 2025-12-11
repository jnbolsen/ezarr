# EZARR

This project makese it EZ to deploy a media stack with the [proper permissions and setup](https://wiki.servarr.com/docker-guide). It features:
- [Sonarr](https://sonarr.tv/) - An application to manage TV shows. It is capable of keeping track
  of what you'd like to watch, at what quality, in which language and more. Used in conjunction with
  applications like qBittorrent and Prowlarr (see below), it provides easy searchign and colleciton
  management. It can also reorganize the media you already own in order to create a more uniformly
  formatted collection.
- [Radarr](https://radarr.video/) - Like Sonarr, but for movies.
- [Lidarr](https://lidarr.audio/) - Like Sonarr, but for music.
- [Prowlarr](https://wiki.servarr.com/prowlarr) - Keeps track of indexers, which are services that
  keep track of Torrent or UseNet links.
- [qBittorrent](https://www.qbittorrent.org/) - Torrent downloader. Also provides a bunch more
  features for management.
- [Qbitmanage](https://github.com/StuffAnThings/qbit_manage) - Qbittorrent manager.
- [Cross-Seed](https://github.com/cross-seed/cross-seed) - Cross-seed manager for Qbittorrent and other torrent downloaders.
- [Overseerr](https://overseerr.dev/) - Request manager for the arr suite.
- [Notifiarr](https://notifiarr.com/guest/login) - Client that connects to TRaSH Guides for automatic radarr and sonarr profile and quality updates (can do many other things too).
- [Tautulli](https://tautulli.com/) - Monitoring application for Plex which can keep track of
  what has been watched, who watched it, when and where they watched it, and how it was watched.

This stack does not include a media player (Plex, Jellyfin, etc) since it is on a different server in my case.

## Requirements
[Docker](https://docs.docker.com/engine/install/) is installed.

The following packages are installed:
- nfs-common (nfs client)
- qemu-agent (for proxmox)

`sudo apt install nfs-common qemu-guest-agent`

The following is set up:
- NFS share mounts with correct ownership of top level direcctories (media:mediacenter) and permissions (umask 022), as required (in my case, media and download shares).
- Make docker depend on NFS share mounts (qbittorrent may prevent shutdown if not).

## Usage
Create a directory of your choice (e.g. `~/ezarr`) to hold the `docker-commpose.yml` and `.env` files.

`mkdir ~/ezarr`

Move to the directory you created.

`cd ~/ezarr`

Download `docker-compose.yml`, `example.env`, and `setup.sh`.

`wget -O docker-compose.yml https://github.com/jnbolsen/ezarr/blob/main/docker-compose.yml`

`wget -O .env https://github.com/jnbolsen/ezarr/blob/main/example.env`

`wget -O setup.sh https://github.com/jnbolsen/ezarr/blob/main/setup.sh`

Populate the environment variables to your liking.
- Set your [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) with `TIMEZONE`.
- Set your docker configuration directory location with `CONFIG_DIR`.
- Set your media data directory location with `DATA_DIR`.
- Set your media download directory location with `DOWNLOAD_DIR`.

Make the setup script executable.

`sudo chmod +x setup.sh`

Run the setup script as a superuser. This will set up your users, a system of directories, and ensure permissions are set correctly.

`sudo ./setup.sh`

Comment out any services in the docker compose file you would like to ignore by placing # in front of the lines.

From the directory you created (which should now contain your customized `docker-compose.yml` and `.env` files), run the following command to start your media stack as a background service:

`sudo docker compose up -d`

That's it! Your containers are now running and you can continue to set up the settings in them.

## Post Installation Notes
- When linking one service to another, you may use the container name instead of `localhost`.
- Use [TRaSH Guides](https://trash-guides.info/) for help in optimizing the -arr suite, plex, and qbittorrent.
- You'll have to add indexers in Prowlarr by hand. Use Prowlarrs settings to connect it to the
  other -arr apps.

## Tested Environments
Ubuntu 22.04, 24.04, and 25.10
Debian 12 and 13

## Reference
This is a fork of [Luctia/ezarr](https://github.com/Luctia/ezarr), tailored for my personal use.

## License
[MIT](https://github.com/jnbolsen/ezarr/blob/main/LICENSE.md)
