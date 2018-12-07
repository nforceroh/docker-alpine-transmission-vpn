FROM nforceroh/docker-alpine-base

MAINTAINER Sylvain Martin (sylvain@nforcer.com)

ENV UMASK=000
ENV PUID=3001
ENV PGID=3000

RUN \
  echo "Installing openvpn and transmission" \
  && apk update \
  && apk --no-cache add openvpn shadow bash transmission-daemon \
  && echo "Cleaning up" \
  && rm -rf /var/cache/apk/* /root/.cache /tmp/* 

VOLUME /config

VOLUME /data

EXPOSE 9091

COPY rootfs/ /
