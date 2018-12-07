#!/bin/bash

echo "Running vpnup script"
source /config/.startingenv
env

if [ ! -z "${LAN_NETWORK}" ]; then
  IFS=','; tokens=( ${LAN_NETWORK} )
  for subnet in "${tokens[@]}"; do
    echo "Adding static route for ${subnet} gw ${route_net_gateway}"
    ip route add ${subnet} via ${route_net_gateway} dev eth0
  done
fi
iptables -A INPUT -i tun0 -j ACCEPT
iptables -A OUTPUT -o tun0 -j ACCEPT

LOCALSUBNET=$(grep LOCALSUBNET /config/defaultroute|cut -f2 -d:)
echo "Adding static route for ${LOCALSUBNET} gw ${route_net_gateway}"
ip route add ${LOCALSUBNET} via ${route_net_gateway} dev eth0

echo "Starting transmission"
su - abc -s /bin/bash -c "/usr/bin/transmission-daemon --config-dir /config"


