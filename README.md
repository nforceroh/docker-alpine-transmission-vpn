# docker-alpine-deluge-vpn
My tweaked image with NFS support

based on alpine

docker create \
  --restart always \
  --cap-add=NET_ADMIN \
  --name transmission\
  --cpus=1 \
  --memory=1g \
  -p 9091:9091 \
  -v transmission_cfg:/config \
  -e TZ=America/New_York \
  -e VPN_ENABLED=yes \
  -e VPN_USER=XXXXXX@slickvpn.com \
  -e VPN_PASS=YYYYYY \
  -e VPNCONFIG=United-States-Atlanta.ovpn \
  -e LAN_NETWORK=10.0.0.0/24,192.168.252.0/22 \
  -e NAME_SERVERS=8.8.8.8,1.1.1.1 \
  -e ENABLE_NFS=true \
  -e NFSSHARE1=10.0.0.100:/mnt/R5_3x5TB_01/export/p2p/torrent:/data \
  -e UMASK=000 \
  -e PUID=3001 \
  -e PGID=3000 \
  -e USERNAME=admin \
  -e PASSWORD=BLABLA \
  -e TRANSMISSION_WEB_HOME=/app/web-ui \
  -e TRANSMISSION_WEB_UI=/app/web-ui/kettu \
   nforceroh/docker-alpine-transmission-vpn
docker start transmission
