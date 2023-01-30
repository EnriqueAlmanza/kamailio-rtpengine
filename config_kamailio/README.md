## kamailio-rtpengine-webrtc
Kamailio and RTPengine implementation installed in Docker containers.

### Prerequisites
-Set certificate to use TLS with Kamailio 

-The configuration files in this folder are ready to work with WebRTC-clients

Locate the certificate, private key and calist in the following location (configured in kamailio-modules.cfg)
```bash
modparam("tls","certificate","/home/certificate/kamailio_cert.pem")
modparam("tls","private_key","/home/certificate/privkey.pem")
modparam("tls","ca_list","/etc/pki/CA/catlist.pem")
```

Reference:
https://kamailio.org/docs/modules/5.5.x/modules/tls.html
