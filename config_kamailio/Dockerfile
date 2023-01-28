#Kamailio Base image
FROM kikealmanza/masterkam:55

#Configuration files using webRTC
#COPY webrtc/kamailio.cfg /etc/kamailio/kamailio.cfg
#COPY webrtc/kamailio-address.cfg /etc/kamailio/kamailio-address.cfg
#COPY webrtc/kamailio-routing.cfg /etc/kamailio/kamailio-routing.cfg
#Standard configuration files
COPY kamailio.cfg /etc/kamailio/kamailio.cfg
COPY kamctlrc /etc/kamailio/kamctlrc
COPY kamailio /etc/default/kamailio
COPY logrotate/50-default.conf /etc/rsyslog.d/50-default.conf
COPY startup.sh /etc/kamailio/startup.sh

#Adding executing permissions
RUN chmod +x /etc/kamailio/startup.sh

#Initial command when starting up the container
ENTRYPOINT ["/etc/kamailio/startup.sh"]
