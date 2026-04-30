FROM linuxserver/webtop:alpine-i3

LABEL org.opencontainers.image.title="wonderbird" \
      org.opencontainers.image.description="Single-application Thunderbird webtop based on linuxserver/webtop alpine-i3." \
      org.opencontainers.image.authors="pthoelken" \
      org.opencontainers.image.url="https://github.com/pthoelken/wonderbird" \
      org.opencontainers.image.source="https://github.com/pthoelken/wonderbird" \
      org.opencontainers.image.base.name="linuxserver/webtop:alpine-i3"

COPY config/i3config /defaults/i3config
COPY config/keep-thunderbird-open.sh /usr/local/bin/keep-thunderbird-open
COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache thunderbird

RUN mkdir -p /config/.config/i3 \
    && cp /defaults/i3config /config/.config/i3/config \
    && chmod +x /entrypoint.sh /usr/local/bin/keep-thunderbird-open

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3000
VOLUME /config
