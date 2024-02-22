# ohol-server

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/schmailzl/ohol-server)
![GitHub issues](https://img.shields.io/github/issues-raw/m-schmailzl/ohol-server)
![License](https://img.shields.io/github/license/m-schmailzl/ohol-server)
![Docker Image Size (amd64)](https://img.shields.io/docker/image-size/schmailzl/ohol-server)
![Docker Pulls](https://img.shields.io/docker/pulls/schmailzl/ohol-server)
![Docker Stars](https://img.shields.io/docker/stars/schmailzl/ohol-server)

Dockerized game server for One Hour One Life by Jason Rohrer [https://onehouronelife.com](https://onehouronelife.com/).

New releases of the game are built automatically. The tag "latest" refers to the current stable version of the game.

Feel free to open an issue on GitHub if a future version of the game does not work. You can contact me if you need a specific older version.

This image is available for AMD64, i386, ARMv6 and ARM64, so you can run the game server e.g. on a Raspberry Pi or an Apple Silicon Mac, too.

## Usage

You can configure your server in the config files located at `/opt/OneLife/server/settings`.\
Server save data is located at `/opt/OneLife/server/data`.

### Docker Compose

A sample docker-compose.yml could look like this:

```yaml
version: '3'
services:
  ohol:
    image: schmailzl/ohol-server
    volumes:
      - ./data:/opt/OneLife/server/data
      - ./settings:/opt/OneLife/server/settings
    ports:
      - "8005:8005"
```
