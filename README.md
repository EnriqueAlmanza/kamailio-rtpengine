## kamailio-rtpengine
Kamailio and RTPengine implementation installed in Docker containers.

### Prerequisites
The script will install the prerequisites software
- Run the install-prereq.sh script

```bash
chmod +x install-prereq.sh
./install-prereq.sh
```

Once Docker and docker-compose are installed create the Kamailio and RTPengine services with docker-compose

```bash
 docker-compose -f docker-compose.yaml build
```

Once the containers are created use the following script to start fresh the containers after they are created using Docker compose

```bash
#!/bin/bash
docker rm -f rtpengine
docker run --network host --privileged --mount source=project_v2_rtpengine,target=/etc/rtpengine --name rtpengine -itd project_v2_rtpengine
docker rm -f kamailio
docker run --network host --privileged --mount source=project_v2_kamailio,target=/etc/kamailio --name kamailio -itd project_v2_kamailio
````








##### References:

https://github.com/kamailio/kamailio

https://github.com/sipwise/rtpengine