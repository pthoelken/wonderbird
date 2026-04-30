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
      SUBFOLDER: /
      TITLE: wonderbird
      SELKIES_MANUAL_WIDTH: "1920"
      SELKIES_MANUAL_HEIGHT: "1080"
      MAX_RESOLUTION: "1920x1080"
      SELKIES_USE_CSS_SCALING: "true"
      SELKIES_UI_SHOW_SIDEBAR: "false|locked"
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
| `TITLE` | Browser page title. |
| `CUSTOM_USER` | Web login username. |
| `PASSWORD` | Web login password. Change this before exposing the service. |
| `SELKIES_MANUAL_WIDTH` / `SELKIES_MANUAL_HEIGHT` | Fixed desktop resolution. |
| `MAX_RESOLUTION` | Maximum allowed resolution. |
| `SELKIES_USE_CSS_SCALING` | Enables browser-side scaling. |
| `SELKIES_UI_SHOW_SIDEBAR` | `false|locked` hides and locks the left Webtop sidebar. |

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
If the window is closed, the process is started again automatically after a short delay.
