# wonderbird

Wonderbird is a small Thunderbird webtop container based on `linuxserver/webtop:alpine-i3`.
It is meant to run Thunderbird as the main browser-accessible application.

## Features

- Thunderbird in a web browser
- i3-based lightweight desktop
- Thunderbird restarts automatically when it is closed
- Selkies/Webtop sidebar hidden and locked
- Persistent Thunderbird profile in the `/config` volume
- Published image: `pthoelken/wonderbird:latest`
- Multi-arch image for x86-64 PCs, Apple Silicon Macs, and 64-bit Raspberry Pi systems

## Quick Start

Create a `docker-compose.yml` like this:

```yaml
name: wonderbird

services:
  wonderbird:
    image: pthoelken/wonderbird:latest
    container_name: wonderbird
    environment:
      PUID: 1000
      PGID: 1000
      TZ: Europe/Berlin
      CUSTOM_USER: "pthoelken"
      PASSWORD: "change-me"
    ports:
      - "3000:3000"
    volumes:
      - wonderbird:/config
    shm_size: "1gb"
    restart: unless-stopped

volumes:
  wonderbird:
```

Start the container:

```bash
docker compose up -d
```

Open:

```text
http://localhost:3000
```

Log in with `CUSTOM_USER` and `PASSWORD`.

## Configuration

| Variable | Purpose |
| --- | --- |
| `PUID` / `PGID` | User and group ID used inside the container for file ownership. |
| `TZ` | Time zone, for example `Europe/Berlin`. |
| `CUSTOM_USER` | Web login username. |
| `PASSWORD` | Web login password. Change this before exposing the service. |

Wonderbird ships opinionated image defaults for the webtop behavior: X11/i3 startup, 2K maximum framebuffer, 1920x1080 initial mode, CSS scaling for HiDPI clients, hidden Webtop sidebar, disabled unused Webtop features, and hardened window-manager close paths.
You can still override any of these with environment variables in your compose file when a deployment needs different behavior.

## Builds

The Docker image is built and pushed by GitHub Actions on every push, on manual workflow dispatch, and weekly on Mondays at 03:17 UTC.

## Persistence

Thunderbird data is stored in `/config`.
The compose file maps that path to the named Docker volume `wonderbird`, so mail accounts and Thunderbird settings survive container updates.

## Updating

Pull the newest image and recreate the container:

```bash
docker compose pull
docker compose up -d
```

## Notes

Thunderbird is watched by `keep-thunderbird-open`.
The i3 config removes borders, fullscreen-maximizes Thunderbird, and disables the common `Alt+q`, terminal, and launcher shortcuts. If the process is still closed through an in-app action, the watchdog starts it again after a short delay.
