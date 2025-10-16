# EZARR
[![Check running](https://github.com/Luctia/ezarr/actions/workflows/check_running.yml/badge.svg)](https://github.com/Luctia/ezarr/actions/workflows/check_running.yml)

This is a fork from [Luctia/ezarr](https://github.com/Luctia/ezarr), tailored for my personal use.

Ezarr is a project built to make it easy (EZ) to deploy a servarr mediacenter on an Ubuntu server with the proper permissions and setup as listed in this [Docker Guide](https://wiki.servarr.com/docker-guide). It features:
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
- [Tautulli](https://tautulli.com/) - Monitoring application for PleX which can keep track of
  what has been watched, who watched it, when and where they watched it, and how it was watched.

This does not include a media player (Plex, Jellyfin, etc) since it is on a different server in my case. 

## Prerequisites
Required packages are installed:
  - qemu-agent (for proxmox).
  - curl.

`apt install qemu-guest-agent curl`

The following is set up:
  - NFS share mounts, as required (in my case, media and download shares).
  - Make docker depend on NFS share mounts (qbittorrent may prevent shutdown if not).

## Using
1. To get started, clone the repository in a directory of your choosing.  Usually the user home directory.
2. Copy `.env.sample` to a real `.env` by running `cp .env.sample .env`.
3. Set the environment variables to your liking. Note that `ROOT_DIR` should be the directory you
   have cloned this in.
4. Run `setup.sh` as superuser. This will set up your users, a system of directories, ensure
   permissions are set correctly.
5. Run `docker compose up -d`.

That's it! Your containers are now running and you can continue to set up the settings in them.

## Post Installation Notes
- When linking one service to another, remember to use the container name instead of `localhost`.
- Use [TRaSH Guides](https://trash-guides.info/) for help in optimizing the -arr suite, plex, and qbittorrent.
- You'll have to add indexers in Prowlarr by hand. Use Prowlarrs settings to connect it to the
  other -arr apps.
