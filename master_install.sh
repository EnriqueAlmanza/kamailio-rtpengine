#!/bin/bash
############################
###Kamailio configuration###
############################
function create_rtpengineconf() {
  RTPconf="./rtpengine.conf"
  /bin/cat <<EOM >$RTPconf
[rtpengine]
table = -1
interface = $IP
listen-ng = localhost:2223
listen-http = localhost:2225
listen-cli = localhost:2224
timeout = 60
silent-timeout = 3600
tos = 184
port-min = 30000
port-max = 40000
recording-dir = /var/spool/rtpengine
recording-method = proc

[rtpengine-testing]
table = -1
interface = $IP
listen-ng = 2223
foreground = true
log-stderr = true
log-level = 7
EOM
}

function create_kamailio_address() {
  kamAddress="./kamailio-address.cfg"
  /bin/cat <<EOM >$kamAddress
#!KAMAILIO
#!substdef "!MY_IP_ADDR!$IP!g"
#!substdef "!MY_DOMAIN!debian-test.youcon.voip!g"
#!substdef "!MY_WS_PORT!88080!g"
#!substdef "!MY_WSS_PORT!44443!g"
#!substdef "!MY_WS_ADDR!tcp:MY_IP_ADDR:MY_WS_PORT!g"
#!substdef "!MY_WSS_ADDR!tls:MY_IP_ADDR:MY_WSS_PORT!g"
EOM
}

function running_containers() {
  echo "Using docker compose to start the containers"
  docker compose build --no-cache
  docker compose up -d
}

clear
IP=$(ip add | sed -En \
's/127.0.0.1//;s/172.17.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
{
  prompt="Configure Kamailio with the address $IP? (y/n): "
  read -p "$prompt" decision
  echo -e "Answer: [$decision]"
}
if [[ $decision = "n" ]]
then
  {
    prompt="Enter the new Kamailio IP - e.g., 192.168.10.3: "
    read -p "$prompt" IP
    echo -e "New IP: [$IP]"
  }
  echo -e "Generating kamailio-address.cfg file \n"
  create_kamailio_address $IP
elif [[ $decision = "y" ]]
then
  echo -e "Generating kamailio-address.cfg file \n"
  create_kamailio_address $IP
else
  echo "Please, enter a correct option (y/n)"
  exit
fi
#############################
###RTPengine configuration###
#############################
{
  prompt="Configure RTPengine with the address $IP? (y/n): "
  read -p "$prompt" decision
  echo -e "Answer: [$decision]"
}
if [[ $decision = "n" ]]
then
  {
    prompt="Enter the new RTPengine IP- e.g., 192.168.10.3: "
    read -p "$prompt" IP
    echo -e "New IP: [$IP]"
  }
  echo -e "Generating rtpengine.conf file \n"
  create_rtpengineconf $IP
  running_containers
elif [[ $decision = "y" ]]
then
  echo "Generating rtpengine.conf file"
  create_rtpengineconf $IP
  running_containers
else
  echo "Please, enter a correct option. Terminating..."
  exit
fi