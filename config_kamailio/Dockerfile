#Kamailio Base image
FROM kikealmanza/masterkam:55

#Optional modifying Kamailio Installation
COPY kamailio.cfg /etc/kamailio/kamailio.cfg
COPY kamailio-address.cfg /etc/kamailio/kamailio-address.cfg
COPY kamailio-routing.cfg /etc/kamailio/kamailio-routing.cfg
COPY kamctlrc /etc/kamailio/kamctlrc
COPY kamailio /etc/default/kamailio
COPY 50-default.conf /etc/rsyslog.d/50-default.conf
COPY startup.sh /etc/kamailio/startup.sh

#Adding executing permissions
RUN chmod 600 /etc/kamailio/startup.sh

#Initial command when starting up the container
ENTRYPOINT ["/etc/kamailio/startup.sh"]
