#Kamailio Base image
FROM kikealmanza/masterkam:55

#Configuration files
#COPY kamailio.cfg /etc/kamailio/kamailio-simple.cfg
#Configuration files using websocket
COPY kamailio.cfg /etc/kamailio/kamailio.cfg
COPY kamailio-modules.cfg /etc/kamailio/kamailio-modules.cfg
COPY kamailio-address.cfg /etc/kamailio/kamailio-address.cfg
COPY kamailio /etc/default/kamailio
COPY logrotate/50-default.conf /etc/rsyslog.d/50-default.conf
COPY startup.sh /etc/kamailio/startup.sh

#Adding executing permissions
RUN chmod +x /etc/kamailio/startup.sh

#Initial command when starting up the container
ENTRYPOINT ["/etc/kamailio/startup.sh"]
