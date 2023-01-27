#!/bin/bash
SHM_MEM=512
PKG_MEM=64
FILE=/startup.sh
export KAM_CONFIG=/etc/kamailio/kamailio.cfg
kamailio=$(which kamailio)

#Start database
/etc/init.d/mysql start

#Check kamailio syntax file
$kamailio -f $KAM_CONFIG -c

#Run kamailio
$kamailio -f $KAM_CONFIG -m "${SHM_MEM}" -M "${PKG_MEM}" -DD -E -e
