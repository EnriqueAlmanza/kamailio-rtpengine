#!/bin/bash
############################
###Kamailio configuration###
############################
clear
echo "Configure Kamailio with the following IP address? (y/n)"
ip add | sed -En 's/127.0.0.1//;s/172.17.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'
read decision
if [[ $decision = "n" ]]
then
 echo "Enter the new IP - e.g., 192.168.10.3: "
 read IP
 echo ${IP} >> IP
 while IFS= read -r IP; do
  echo "Configuring IP ${IP} to kamailio-address.cfg file"
  echo "MY_IP_ADDR=${IP}" >> kamailio_address.cfg
 done < IP
 rm IP
elif [[ $decision = "y" ]]
then
 ip add | sed -En 's/127.0.0.1//;s/172.17.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' >> IP
 while IFS= read -r IP; do
  echo "Configuring Kamailio with IP: $IP"
  echo "MY_IP_ADDR=${IP}" >> kamailio_address.cfg
 done < IP
 rm IP
else
 echo "Please, enter a correct option (y/n)"
fi
#############################
###RTPengine configuration###
#############################
echo "Configure RTPengine with the following IP address? (y/n)"
ip add | sed -En 's/127.0.0.1//;s/172.17.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'
read decision
if [[ $decision = "n" ]]
then
 echo "Enter the new IP - e.g., 192.168.10.3: "
 read IP
 echo ${IP} >> IP
 while IFS= read -r IP; do
  echo "Configuring IP ${IP} to kamailio-address.cfg file"
  echo "modparam("rtpengine", "rtpengine_sock", "udp:${IP}:2223")" >> kamailio_address.cfg
 done < IP
 rm IP
elif [[ $decision = "y" ]]
then
 ip add | sed -En 's/127.0.0.1//;s/172.17.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' >> IP
 while IFS= read -r IP; do
  echo "Configuring RTPengine with IP: $IP"
  echo "modparam("rtpengine", "rtpengine_sock", "udp:${IP}:2223")" >> kamailio_address.cfg
 done < IP
 rm IP
 docker-compose -f docker-compose.yaml up -d
 docker rm -f rtpengine
 docker run --network host --privileged --mount source=project_v2_rtpengine,target=/etc/rtpengine --name rtpengine -itd project_v2_rtpengine
 docker rm -f kamailio
 docker run --network host --privileged --mount source=project_v2_kamailio,target=/etc/kamailio --name kamailio -itd project_v2_kamailio
else
 echo "Please, enter a correct option. Terminating..."
fi
