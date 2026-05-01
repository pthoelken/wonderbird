FROM linuxserver/webtop:alpine-i3

LABEL org.opencontainers.image.title="wonderbird" \
      org.opencontainers.image.description="Single-application Thunderbird webtop based on linuxserver/webtop alpine-i3." \
      org.opencontainers.image.authors="Patrick Thoelken" \
      org.opencontainers.image.url="https://github.com/pthoelken/wonderbird" \
      org.opencontainers.image.source="https://github.com/pthoelken/wonderbird" \
      org.opencontainers.image.base.name="linuxserver/webtop:alpine-i3"

ENV SUBFOLDER="/" \
    TITLE="Wonderbird - Webbased Thunderbird Mail Client" \
    PIXELFLUX_WAYLAND="false" \
    MAX_RES="2560x1440" \
    MAX_RESOLUTION="2560x1440" \
    SELKIES_MANUAL_WIDTH="1920" \
    SELKIES_MANUAL_HEIGHT="1080" \
    SELKIES_IS_MANUAL_RESOLUTION_MODE="true|locked" \
    WONDERBIRD_INITIAL_RESOLUTION="1920x1080" \
    SELKIES_USE_CSS_SCALING="true|locked" \
    SELKIES_SCALING_DPI="96" \
    SELKIES_FRAMERATE="24" \
    SELKIES_H264_CRF="30" \
    SELKIES_JPEG_QUALITY="75" \
    SELKIES_PAINT_OVER_JPEG_QUALITY="80" \
    SELKIES_AUDIO_ENABLED="false|locked" \
    SELKIES_MICROPHONE_ENABLED="false|locked" \
    SELKIES_GAMEPAD_ENABLED="false|locked" \
    SELKIES_SECOND_SCREEN="false|locked" \
    SELKIES_ENABLE_SHARING="false|locked" \
    SELKIES_FILE_TRANSFERS="" \
    SELKIES_UI_SHOW_SIDEBAR="false|locked" \
    NO_DECOR="true" \
    HARDEN_DESKTOP="true" \
    HARDEN_OPENBOX="true" \
    DISABLE_CLOSE_BUTTON="true" \
    HARDEN_KEYBINDS="true" \
    RESTART_APP="true" \
    GTK_CSD="0" \
    MOZ_GTK_TITLEBAR_DECORATION="system"

COPY config/i3config /defaults/i3config
COPY config/startwm.sh /defaults/startwm.sh
COPY config/keep-thunderbird-open.sh /usr/local/bin/keep-thunderbird-open
COPY config/thunderbird-autoconfig.js /defaults/thunderbird-autoconfig.js
COPY config/wonderbird.cfg /defaults/wonderbird.cfg

RUN apk add --no-cache thunderbird

RUN mkdir -p /config/.config/i3 \
    && cp /defaults/i3config /config/.config/i3/config \
    && cp /defaults/thunderbird-autoconfig.js /usr/lib/thunderbird/defaults/pref/wonderbird-autoconfig.js \
    && cp /defaults/wonderbird.cfg /usr/lib/thunderbird/wonderbird.cfg \
    && chmod +x /defaults/startwm.sh \
    && chmod +x /usr/local/bin/keep-thunderbird-open

EXPOSE 3000
VOLUME /config
