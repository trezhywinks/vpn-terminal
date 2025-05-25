#!/bin/bash

RED="$(printf '\033[31m')"  WHITE="$(printf '\033[37m')"
ORG="$(printf '\e[1;93m Werbot Ver : 1.0')" MAGENTA="$(printf '\033[35m')" 
REF="$(printf ' \e[1;37m\n')" BLACK="$(printf '\033[30m')"

printf " \e[1;37m\n"

USER="vpnbook"
PASS="cf32e5w"
AUTH_FILE="vpn.auth"

echo -e "$USER\n$PASS" > $AUTH_FILE
chmod 600 $AUTH_FILE 

START_VPN(){
cat << EOF

[::] Select an option

${WHITE}[${RED}01${WHITE}]${BLACK} vpnbook-fr200-tcp443.ovpn     ${WHITE} [${RED}04${WHITE}]${BLACK} vpnbook-fr200-udp53.ovpn
${WHITE}[${RED}02${WHITE}]${BLACK} vpnbook-fr200-tcp80.ovpn      ${WHITE} [${BLACK}00${WHITE}]${BLACK} exit
${WHITE}[${RED}03${WHITE}]${BLACK} vpnbook-fr200-udp25000.ovpn

EOF

read -p "${BLACK}┌──(${RED}select${BLACK})-[${WHITE}vpn-terminal${BLACK}]
└─>${RED} " REPLY

case $REPLY in
    1 | 01)
       echo -e "${BLACK}[${WHITE}::${BLACK}]${MAGENTA} Starting the VPN...${WHITE}";
       sleep 0.75;
        openvpn --config openvpn/vpnbook-fr200-tcp443.ovpn --auth-user-pass $AUTH_FILE;;
    
    2 | 02)
       echo -e "${BLACK}[${WHITE}::${BLACK}]${MAGENTA} Starting the VPN...${WHITE}";
       sleep 0.75;
        openvpn --config openvpn/vpnbook-fr200-tcp80.ovpn  --auth-user-pass $AUTH_FILE;;

    3 | 03)
       echo -e "${BLACK}[${WHITE}::${BLACK}]${MAGENTA} Starting the VPN...${WHITE}";
       sleep 0.75;
        openvpn --config openvpn/vpnbook-fr200-udp25000.ovpn --auth-user-pass $AUTH_FILE;;

    4 | 04)
       echo -e "${BLACK}[${WHITE}::${BLACK}]${MAGENTA} Starting the VPN...${WHITE}";
       sleep 0.75;
        openvpn --config openvpn/vpnbook-fr200-udp53.ovpn --auth-user-pass $AUTH_FILE;;
    
    0 | 00)
    exit;;
    *)
        echo -ne "${WHITE}[${RED}!${WHITE}]${RED} Erro, Try again${WHITE}"
        { sleep 0.75; clear; START_VPN; }
        ;;
esac
}

START_VPN
