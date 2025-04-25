#/bin/bash^M
# DNSTT Server DNSTT Custom
# Script by UnknownDEV
#

#!/bin/bash

progreSh() {
    LR='\033[1;31m'
    LG='\033[1;32m'
    LY='\033[1;33m'
    LC='\033[1;36m'
    LW='\033[1;37m'
    NC='\033[0m'
    if [ "${1}" = "0" ]; then TME=$(date +"%s"); fi
    PRC=`printf "%.0f" ${1}`
    SHW=`printf "%3d\n" ${PRC}`
    LNE=`printf "%.0f" $((${PRC}/2))`
    LRR=`printf "%.0f" $((${PRC}/2-12))`; if [ ${LRR} -le 0 ]; then LRR=0; fi;
    LYY=`printf "%.0f" $((${PRC}/2-24))`; if [ ${LYY} -le 0 ]; then LYY=0; fi;
    LCC=`printf "%.0f" $((${PRC}/2-36))`; if [ ${LCC} -le 0 ]; then LCC=0; fi;
    LGG=`printf "%.0f" $((${PRC}/2-48))`; if [ ${LGG} -le 0 ]; then LGG=0; fi;
    LRR_=""
    LYY_=""
    LCC_=""
    LGG_=""
    for ((i=1;i<=13;i++))
    do
    	DOTS=""; for ((ii=${i};ii<13;ii++)); do DOTS="${DOTS}."; done
    	if [ ${i} -le ${LNE} ]; then LRR_="${LRR_}#"; else LRR_="${LRR_}."; fi
    	echo -ne "  ${LW}${SEC}  ${LR}${LRR_}${DOTS}${LY}............${LC}............${LG}............ ${SHW}%${NC}\r"
    	if [ ${LNE} -ge 1 ]; then sleep .05; fi
    done
    for ((i=14;i<=25;i++))
    do
    	DOTS=""; for ((ii=${i};ii<25;ii++)); do DOTS="${DOTS}."; done
    	if [ ${i} -le ${LNE} ]; then LYY_="${LYY_}#"; else LYY_="${LYY_}."; fi
    	echo -ne "  ${LW}${SEC}  ${LR}${LRR_}${LY}${LYY_}${DOTS}${LC}............${LG}............ ${SHW}%${NC}\r"
    	if [ ${LNE} -ge 14 ]; then sleep .05; fi
    done
    for ((i=26;i<=37;i++))
    do
    	DOTS=""; for ((ii=${i};ii<37;ii++)); do DOTS="${DOTS}."; done
    	if [ ${i} -le ${LNE} ]; then LCC_="${LCC_}#"; else LCC_="${LCC_}."; fi
    	echo -ne "  ${LW}${SEC}  ${LR}${LRR_}${LY}${LYY_}${LC}${LCC_}${DOTS}${LG}............ ${SHW}%${NC}\r"
    	if [ ${LNE} -ge 26 ]; then sleep .05; fi
    done
    for ((i=38;i<=49;i++))
    do
    	DOTS=""; for ((ii=${i};ii<49;ii++)); do DOTS="${DOTS}."; done
    	if [ ${i} -le ${LNE} ]; then LGG_="${LGG_}#"; else LGG_="${LGG_}."; fi
    	echo -ne "  ${LW}${SEC}  ${LR}${LRR_}${LY}${LYY_}${LC}${LCC_}${LG}${LGG_}${DOTS} ${SHW}%${NC}\r"
    	if [ ${LNE} -ge 38 ]; then sleep .05; fi
    done
}

# Check if root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#OS 
_os() {
    local os=""
    [ -f "/etc/debian_version" ] && source /etc/os-release && os="${ID}" && printf -- "%s" "${os}" && return
    [ -f "/etc/redhat-release" ] && os="centos" && printf -- "%s" "${os}" && return
}

_os_full() {
    [ -f /etc/redhat-release ] && awk '{print ($1,$3~/^[0-9]/?$3:$4)}' /etc/redhat-release && return
    [ -f /etc/os-release ] && awk -F'[= "]' '/PRETTY_NAME/{print $3,$4,$5}' /etc/os-release && return
    [ -f /etc/lsb-release ] && awk -F'[="]+' '/DESCRIPTION/{print $2}' /etc/lsb-release && return
}

_os_ver() {
    local main_ver="$( echo $(_os_full) | grep -oE  "[0-9.]+")"
    printf -- "%s" "${main_ver%%.*}"
}

###### Extractor informacion server  ######
PLUGINS_JAQUEMATEV='1.2'
opsy=$( _os_full )
arch=$( uname -m )
lbit=$( getconf LONG_BIT )
kern=$( uname -r )
default_int="$(ip route list |grep default |grep -o -P '\b[a-z]+\d+\b')"
SERVER_PORT_V2RAY='46210'
#Cambia keys DNSTTT no es llave de APP
SERVER_DNSTT_KEY='df048842967bb8601299a04baab526b2713c1481a6ff9f63e7458a64ba7c2902'


################## INSTALL ##################
clear
echo "-----------------------------------------------------------------------------"
echo "              Auto Script DNSTT Custom By JaqueMate HTTP!!!"
echo "-----------------------------------------------------------------------------"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '\e[104m                             Author UnknowDEV                                 ' ; tput sgr0
echo ""
echo ""
sleep 7


echo ""
echo "                    [*] DNSTT Server AUTH.."
read -p "                 NameServer Domains : " -e -i dns.jaquematedns.xyz DnsNS
clear

echo "              [*] Update SERVER.."
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical
progreSh 10
sudo -E apt-get -qy -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" update >/dev/null 2>&1;
progreSh 40
sudo -E apt-get -qy -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade -y >/dev/null 2>&1;
progreSh 60
sudo -E apt-get -qy -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" install gnupg gnupg2 gnupg1 dnsutils iptables-persistent wget curl software-properties-common -y >/dev/null 2>&1;
progreSh 100
printf "\n\n"

echo "              [*] Install PACKAGE...."
echo "              [*] Wait...."
while read -r p ; do sudo apt-get install -y $p >/dev/null 2>&1 ; done < <(cat << "EOF"
    nano
    g++
    git
    python
    python3-pip
    dos2unix
    iptables
    stunnel4
    fail2ban
    default-jdk
    pkg-config libssl-dev libnspr4-dev libnss3-dev
    cmake
    screen wget gcc build-essential g++ make
    gcc zip git curl wget unzip screen net-tools
    nload
    htop
EOF
)
printf "\n\n"
clear

echo "                 [*] DNSTT"
apt install git -y >/dev/null 2>&1;
progreSh 10
wget -c https://www.dropbox.com/s/vq5k1qixtersd80/dnstt-server?dl=0 -O /usr/local/bin/dnstt-server >/dev/null 2>&1;
wget -c https://www.dropbox.com/s/a0zr8hd4vb89s81/server.key?dl=0 -O /usr/local/bin/server.key >/dev/null 2>&1;
wget -c https://www.dropbox.com/s/h6ep3vh7ev409cl/server.pub?dl=0 -O /usr/local/bin/server.pub >/dev/null 2>&1;
progreSh 40
sleep 2
chmod +x /usr/local/bin/dnstt-server >/dev/null 2>&1;
chmod +x /usr/local/bin/server.key >/dev/null 2>&1;
chmod +x /usr/local/bin/server.pub >/dev/null 2>&1;
sleep 1
progreSh 100
printf "\n\n"


echo '                 [*] DNSTT Binary JaqueMate Inject'
cat <<EOF > /etc/systemd/system/dnstt-service.service
[Unit]
Description=Daemonize DNSTT Tunnel Server
Wants=network.target
After=network.target
[Service]
ExecStart=/usr/local/bin/dnstt-server -udp :5300 -privkey $SERVER_DNSTT_KEY $DnsNS 127.0.0.1:$SERVER_PORT_V2RAY
Restart=always
RestartSec=3
[Install]
WantedBy=multi-user.target
EOF
progreSh 10
systemctl daemon-reload >/dev/null 2>&1;
systemctl start dnstt-service >/dev/null 2>&1;
systemctl enable --now dnstt-service >/dev/null 2>&1;
progreSh 100
printf "\n\n"

echo '                 [*] Service TB'
cat <<EOF > /etc/systemd/system/hashes-iptables.service
[Unit]
Description=Iptables reboot
Before=network.target
[Service]
Type=oneshot
ExecStart=/usr/sbin/iptables -I INPUT -p udp --dport 5300 -j ACCEPT
ExecStart=/usr/sbin/iptables -t nat -I PREROUTING -i $default_int -p udp --dport 0:65535 -j REDIRECT --to-ports 5300
ExecStart=/usr/sbin/ip6tables -I INPUT -p udp --dport 5300 -j ACCEPT
ExecStart=/usr/sbin/ip6tables -t nat -I PREROUTING -i $default_int -p udp --dport 0:65535 -j REDIRECT --to-ports 5300
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target
EOF
progreSh 10
systemctl daemon-reload >/dev/null 2>&1;
systemctl start hashes-iptables.service >/dev/null 2>&1;
systemctl enable --now hashes-iptables.service >/dev/null 2>&1;
progreSh 100
clear
printf "\n\n"


echo "              [*] V2ray"
printf "\n\n"
echo '              [*] Starting Services'
sleep 5
bash <(curl -sS https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)>/dev/null 2>&1;
bash <(curl -sS https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh) >/dev/null 2>&1;
progreSh 10
progreSh 40
cat <<EOF > /usr/local/etc/v2ray/config.json
{
  "log": null,
  "routing": {
    "rules": [
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "ip": [
          "geoip:private"
        ],
        "outboundTag": "blocked",
        "type": "field"
      },
      {
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ],
        "type": "field"
      }
    ]
  },
  	"dns": {
		"servers": [
			"https+local://1.1.1.1/dns-query",
			"1.1.1.1",
			"1.0.0.1",
			"8.8.8.8",
			"8.8.4.4",
			"localhost"
		]
	},
  "inbounds": [
    {
      "listen": "127.0.0.1",
      "port": $SERVER_PORT_V2RAY,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "f92f7271-87ac-3d48-8971-3352832aa1d9",
            "alterId": 10
          }
        ],
        "disableInsecureEncryption": false
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "path": "/",
          "headers": {}
        }
      },
      "tag": "inbound-8443",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "transport": null,
  "policy": {
    "system": {
      "statsInboundDownlink": true,
      "statsInboundUplink": true
    }
  },
  "api": {
    "services": [
      "HandlerService",
      "LoggerService",
      "StatsService"
    ],
    "tag": "api"
  },
  "stats": {},
  "reverse": null,
  "fakeDns": null
}
EOF
sleep 5
cd /etc/systemd/system/
rm -r v2ray.service
progreSh 60
wget -c https://www.dropbox.com/s/vs8y30ljca2qx9d/v2ray.service?dl=0 -O v2ray.service >/dev/null 2>&1;
chmod +x /etc/systemd/system/v2ray.service
sudo systemctl daemon-reload && sudo systemctl restart v2ray.service >/dev/null 2>&1;
progreSh 100
printf "\n\n"

echo "              [*] V2ray Plugins Faster over DNSTT...."
sleep 12
progreSh 15
sudo mkdir -p /usr/DM
cd /usr/DM
wget --no-check-certificate https://github.com/52fancy/GooGle-BBR/raw/master/BBR.sh >/dev/null 2>&1 && sh BBR.sh >/dev/null 2>&1;
wget -c https://www.dropbox.com/s/4dmqm4gokg4ln3m/JaqueMate_FASTER.sh?dl=0 -O /usr/DM/JaqueMate_FASTER.sh >/dev/null 2>&1;
chmod +x /usr/DM/JaqueMate_FASTER.sh >/dev/null 2>&1;
./JaqueMate_FASTER.sh
progreSh 40
lsmod | grep bbr >/dev/null 2>&1;
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf >/dev/null 2>&1;
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf >/dev/null 2>&1;
sysctl -p >/dev/null 2>&1;
progreSh 100
clear
printf "\n\n"

echo "              [*] Remove apache"
sudo apt-get remove apache2 -y >/dev/null 2>&1;
sudo apt-get remove --auto-remove apache2 -y >/dev/null 2>&1;
sudo apt-get purge apache2 -y >/dev/null 2>&1;
sudo apt-get purge --auto-remove apache2 -y >/dev/null 2>&1;
progreSh 100
printf "\n\n"

cat <<EOT > /etc/autostart
#!/bin/bash
systemctl start v2ray </dev/null >/dev/null 2>&1
echo "[*] Iptable"
service systemd-resolved restart </dev/null >/dev/null 2>&1
echo "[*] Iptable terminado"
EOT
chmod +x /etc/autostart
printf "\n\n"

echo "             [*] Crontab"
sleep 2
crontab <<EOF
@reboot /etc/autostart
* * * * * /etc/autostart
0 */15 * * * sudo reboot
EOF
sleep 2
clear
printf "\n\n"

#information
echo -e "             [*] Installation Completed!"
sleep 3
printf "\n\n"


echo -e "=======================-DNSTT INFO-==========================="
echo -e "          Public Key: "; echo "d4be3917df05fac65a72c1e16f25636da067c717d400b925fb297e2cdaca1864"
echo ""
echo "             NameServer: $DnsNS        "
echo -e "=============================================================="
echo "     Version Plugins Server JaqueMate Binary  : $PLUGINS_JAQUEMATEV"
echo -e "===================-System Information-======================"
echo "   DNS port allowed  : 1 - 65535        "
echo "             OS      : $opsy"
echo "             Arch    : $arch ($lbit Bit)"
echo "             Kernel  : $kern"
echo "             Interf  : $default_int"
echo -e "=============================================================="
tput setaf 7 ; tput setab 4 ; tput bold ; printf '\e[104m                  Powerby JaqueMate HTTP                      ' ; tput sgr0
echo -e "==============================================================="
tput setaf 7 ; tput setab 4 ; tput bold ; printf '\e[104m                  Reboot Server Manual                        ' ; tput sgr0
sleep 7

echo > /var/log/wtmp
echo > /var/log/btmp
echo > ~/.bash_history
cat /dev/null > ~/.bash_history && history -c && exit
clear
history -c
exit
