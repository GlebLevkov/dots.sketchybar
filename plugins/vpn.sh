
VPN_ENABLED=$(ifconfig -a | grep 'flags=80d1<UP,POINTOPOINT,RUNNING,NOARP,MULTICAST> mtu')

if [[ -n "$VPN_ENABLED" ]]; then
  sketchybar --set "vpn" icon="􁅏" label="sfera" drawing=on
else
  sketchybar --set "vpn" drawing=off
fi
