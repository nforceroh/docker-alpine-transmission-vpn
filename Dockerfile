FROM nforceroh/docker-alpine-base

MAINTAINER Sylvain Martin (sylvain@nforcer.com)

ENV UMASK=000
ENV PUID=3001
ENV PGID=3000

RUN \
  echo "Installing openvpn and transmission" \
  && apk update \
  && apk --no-cache add openvpn shadow bash transmission-daemon \
  && echo "Installing Transmission Web Control and UI" \
  && mkdir -p /config/web-ui /config/web-ui/transmission-web-control \
  && cd /config/web-ui \
  && wget -qO- https://github.com/endor/kettu/archive/master.tar.gz | tar xz -C /config/web-ui \ 
  && mv /config/web-ui/kettu-master /config/web-ui/kettu \
  && wget -qO- https://github.com/ronggang/twc-release/raw/master/src.tar.gz | tar xz -C /config/web-ui/transmission-web-control \
  && echo "Cleaning up" \
  && rm -rf /var/cache/apk/* /root/.cache /tmp/* 

VOLUME /config

VOLUME /data

EXPOSE 9091

COPY rootfs/ /
