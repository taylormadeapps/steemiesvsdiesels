#!/bin/sh
set -x
sudo docker run -d -m=0 \
  -p 0.0.0.0:2222:22 -\
  --name=steemiesvsdiesels taylormadeapps/steemiesvsdiesels:latest

	#  -v /var/enactxms/enactdsa-test/tmp:/tmp \
#  -v /var/enactxms/enactdsa-test/enactxms:/var/enactxms \
#  -v /var/enactxms/enactdsa-test/log:/var/log \
#  -v /var/enactxms/enactdsa-test/ldap:/var/lib/ldap \
#  -v /var/enactxms/enactdsa-test/postgresql:/var/lib/postgresql/data \
#  -v /var/enactxms/enactdsa-test/ROOT:/var/lib/tomcat7/webapps/ROOT \
#  --restart=always \
