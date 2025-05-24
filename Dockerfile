from alpine:latest

# deps
run apk --no-cache add wireguard-tools-wg-quick
run apk --no-cache add wireguard-tools-openrc
run apk --no-cache add iptables
run apk --no-cache add curl
run apk --no-cache add yt-dlp

# remove sysctl call
# linuxserver docker-wireguard Dockerfile line 41
run sed -i 's|\[\[ $proto == -4 \]\] && cmd sysctl -q net\.ipv4\.conf\.all\.src_valid_mark=1|[[ $proto == -4 ]] \&\& [[ $(sysctl -n net.ipv4.conf.all.src_valid_mark) != 1 ]] \&\& cmd sysctl -q net.ipv4.conf.all.src_valid_mark=1|' /usr/bin/wg-quick

# copy wireguard config
workdir /etc/wireguard
copy wg0.conf /etc/wireguard
run chmod 300 /etc/wireguard/wg0.conf

# change dir
workdir /data

# enable wireguard & start shell
cmd wg-quick up wg0 && bash
