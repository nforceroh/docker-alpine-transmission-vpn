FROM nforceroh/docker-alpine-base

MAINTAINER Sylvain Martin (sylvain@nforcer.com)

ENV UMASK=000
ENV PUID=3001
ENV PGID=3000
ENV USERNAME admin
ENV PASSWORD password

RUN \
  echo "Installing openvpn and transmission" \
  && apk update \
  && apk --no-cache add openvpn shadow bash transmission-daemon \
  && echo "Installing Transmission Web Control and UI" \
  && mkdir -p /app/web-ui/transmission-web-control \
  && cd /app/web-ui \
  && wget -qO- https://github.com/endor/kettu/archive/master.tar.gz | tar xz -C /app/web-ui \ 
  && mv /app/web-ui/kettu-master /app/web-ui/kettu \
  && wget -qO- https://github.com/ronggang/twc-release/raw/master/src.tar.gz | tar xz -C /app/web-ui/transmission-web-control \
  && echo "Cleaning up" \
  && rm -rf /var/cache/apk/* /root/.cache /tmp/* 

VOLUME /config

VOLUME /data

EXPOSE 9091

COPY rootfs/ /
