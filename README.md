# EZARR
[![Check running](https://github.com/Luctia/ezarr/actions/workflows/check_running.yml/badge.svg)](https://github.com/Luctia/ezarr/actions/workflows/check_running.yml)

This is a fork from [Luctia/ezarr](https://github.com/Luctia/ezarr), tailored for my personal use.

Ezarr is a project built to make it easy (EZ) to deploy a Servarr mediacenter on an Ubuntu server with
the proper permissions and setup as listed in this [Docker Guide](https://wiki.servarr.com/docker-guide).
The badge above means that the shell script and docker-compose file in this repository at least *don't
crash*. It doesn't necessarily mean it will run well on your system. It features:
- [Sonarr](https://sonarr.tv/) - An application to manage TV shows. It is capable of keeping track
  of what you'd like to watch, at what quality, in which language and more. Used in conjunction with
  applications like qBittorrent and Prowlarr (see below), it provides easy searchign and colleciton
  management. It can also reorganize the media you already own in order to create a more uniformly
  formatted collection.
- [Radarr](https://radarr.video/) - Like Sonarr, but for movies.
- [Lidarr](https://lidarr.audio/) - Like Sonarr, but for music.
- [Readarr](https://readarr.com/) - Like Sonarr, but for books.
- [Mylar3](https://github.com/mylar3/mylar3) (currently not used) - Like Sonarr, but for comic books. This one is a bit
  tricky to set up, so do so at your own risk. You'll have to add an API key within Mylar3 yourself
  to connect to other apps, particularly Prowlarr.
- [Prowlarr](https://wiki.servarr.com/prowlarr) - Keeps track of indexers, which are services that
  keep track of Torrent or UseNet links.
- [Jackett](https://github.com/Jackett/Jackett) (currently not used) - Alternative to Prowlarr. 
- [qBittorrent](https://www.qbittorrent.org/) - Torrent downloader, but provides a bunch more
  features for management.
- [PleX](https://www.plex.tv/) - Mediaserver. Using this, you get access to a Netflix-like
  interface across many devices like your laptop or computer, phone, TV and more. For
  some features, you need a [PleX pass](https://www.plex.tv/nl/plex-pass/).
- [Tautulli](https://tautulli.com/) - Monitoring application for PleX which can keep track of
  what has been watched, who watched it, when and where they watched it, and how it was watched.
- [Jellyfin](https://jellyfin.org/) (currently not used) - For and alternative to PleX. Which one you'd like to use is a matter
  of preference. You *could* even use both, although is probably a waste of resources.

## Prerequisites
1. The following packages are installed:
  - cifs using '$ sudo apt install cifs-utils'.
  - qemu-agent (for proxmox) using '$ sudo apt install qemu-guest-agent' then '$ systemctl start qemu-guest-agent' (or reboot).


## Using
1. To get started, clone the repository in a directory of your choosing. **Note: this will be where
   your installation and media will be as well, so think about this a bit.**
2. Copy `.env.sample` to a real `.env` by running `$ cp .env.sample .env`.
3. Set the environment variables to your liking. Note that `ROOT_DIR` should be the directory you
   have cloned this in.
4. Run `setup.sh` as superuser. This will set up your users, a system of directories, ensure
   permissions are set correctly and sets some more environment variables for docker compose.
5. Take a look at the `docker-compose.yml` file. If there are services you would like to ignore
   (for example, running PleX and Jellyfin at the same time is a bit unusual), you can comment them
   out by placing `#` in front of the lines. This ensures they are ignored by Docker compose.
6. Run `docker compose up`.

That's it! Your containers are now running and you can continue to set up the settings in them. Take
note of the following:
- When linking one service to another, remember to use the container name instead of `localhost`.
- Use [TRaSH Guides](https://trash-guides.info/) for help in optimizing the -arr suite, plex, and qbittorrent.
- In qBittorrent, after connecting it to the -arr services, you can indicate it should move
  torrents in certain categories to certain directories, like torrents in the `radarr` category
  to `/data/torrents/movies`. You should do this. Also set the `Default Save Path` to
  `/data/torrents`. Set "Run external program on torrent completion" to true and enter this in the
  field: `chmod -R 775 "%F/"`.
- You'll have to add indexers in Prowlarr by hand. Use Prowlarrs settings to connect it to the
  other -arr apps.
