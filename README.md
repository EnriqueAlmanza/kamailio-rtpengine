# kamailio-rtpengine
Kamailio and RTPengine orchestrated with Docker compose

### Prerequisites
The system was running using Ubuntu

- Run the install-prereq.sh script

The script will install the prerequisites software and will create the folder structure




Bash script to start fresh the containers after they are created using Docker compose

Note: The mount flag needs to be specified otherwise the volumes are not mounted

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