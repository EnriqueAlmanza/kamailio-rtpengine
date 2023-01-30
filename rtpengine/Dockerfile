FROM debian:buster

RUN apt update -y
RUN apt install wget nano -y
RUN wget https://dfx.at/rtpengine/latest/pool/main/r/rtpengine-dfx-repo-keyring/rtpengine-dfx-repo-keyring_1.0_all.deb
RUN dpkg -i rtpengine-dfx-repo-keyring_1.0_all.deb

#Debian release
ENV DIST="buster"
#Rtpengine version
ENV REL="11.1"

RUN echo "deb [signed-by=/usr/share/keyrings/dfx.at-rtpengine-archive-keyring.gpg] \
  https://dfx.at/rtpengine/$REL $DIST main" | tee /etc/apt/sources.list.d/dfx.at-rtpengine.list
RUN apt update -y
RUN apt install rtpengine rsyslog -y

COPY rtpengine.conf /etc/rtpengine/

# Startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

#Command to run every time the container starts
#ENTRYPOINT ["/start.sh"]
ENTRYPOINT /start.sh && /bin/bash
