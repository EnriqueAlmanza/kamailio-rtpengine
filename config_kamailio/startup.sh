#!/bin/bash
SHM_MEM=256
PKG_MEM=64
export KAM_CONFIG=/etc/kamailio/kamailio.cfg
kamailio=$(which kamailio)

#Start database
/etc/init.d/mysql start

#Check kamailio syntax file
$kamailio -f $KAM_CONFIG -c

#Run kamailio
/etc/init.d/kamailio start
$kamailio -f $KAM_CONFIG -m "${SHM_MEM}" -M "${PKG_MEM}" -DD -E -e
