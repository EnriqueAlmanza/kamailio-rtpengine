##### Table of Contents

<!-- TOC -->

* [kamailio-rtpengine](#kamailio-rtpengine)
    * [Prerequisites](#prerequisites)
    * [Certificates](#certificates)
    * [Using "master_install.sh" script](#using--masterinstallsh--script)
    * [References](#references)
<!-- TOC -->

<a name="kamailio-rtpengine"/>

# kamailio-rtpengine
Kamailio and RTPengine implementation installed in Docker containers.

<a name="prerequisites"/>

### Prerequisites
The script will install the prerequisites software
- Run the install-prereq.sh script
```bash
chmod +x install-prereq.sh
./install-prereq.sh
```
- Modify the "/config_kamailio/kamailio-address_bkp.cfg" with your host IP (containers run with network_mode: "host") and rename it to "kamailio-address.cfg"
- Modify the "/rtpengine/rtpengine_bkp.conf" with your host IP (same as Kamailio) and rename the file to "rtpengine.conf"
- Once Docker and docker-compose are installed create the Kamailio and RTPengine services with docker-compose (alternatively use the "master_install.sh" script, see steps below)
```bash
 docker-compose -f docker-compose.yaml build
```

Once the containers are created use the following script to start fresh the containers (if needed)

```bash
#!/bin/bash
docker rm -f rtpengine
docker run --network host --privileged --mount source=project_v2_rtpengine,target=/etc/rtpengine --name rtpengine -itd project_v2_rtpengine
docker rm -f kamailio
docker run --network host --privileged --mount source=project_v2_kamailio,target=/etc/kamailio --name kamailio -itd project_v2_kamailio
````

<a name="certificates"/>

### Certificates
Kamailio runs with a self-signed certificate, exchange if needed with new certificates as:
```bash
certificate: "/home/certificate/kamailio_cert.pem"
private_key: "/home/certificate/privkey.pem"
ca_list: "/etc/pki/CA/catlist.pem"
```

Copy the files and reload the container:
```bash
docker cp kamailio_cert.pem kamailio:/home/certificate/kamailio_cert.pem
docker cp privkey.pem kamailio:/home/certificate/privkey.pem
docker cp catlist.pem kamailio:/etc/pki/CA/catlist.pem
docker exec -it kamailio /etc/init.d/kamailio restart
```

<a name="using--masterinstallsh--script"/>

### Using "master_install.sh" script

The script will run Kamailio and RTPengine in the PC where the script is running. It will start
the Docker containers using the network of the host machine.
The script generates the "kamailio-address.cfg" and "rtpengine.conf" files

<a name="references"/>

### References

Official Kamailio [Kamailio](https://github.com/kamailio/kamailio)

Official RTPengine [RTPengine](https://github.com/sipwise/rtpengine)