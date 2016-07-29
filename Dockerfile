FROM ubuntu:xenial
MAINTAINER Encircle Solutions Ltd support@encircle.co.uk


ENV HOME /root

#set LOCAL Env vars
ENV LANG en_GB.UTF-8
ENV LC_ALL en_GB.UTF-8
ENV LANGUAGE en_GB.UTF-8


RUN LC_ALL=en_GB.UTF-8
RUN LANG=en_GB.UTF-8
RUN LANGUAGE=en_GB.UTF-8
RUN DEBIAN_FRONTEND=noninteractive

# Install modules from apt-get
RUN	apt-get -y update

RUN	apt-get install -q -y openssh-server pwgen wget && \
		apt-get install -q -y gcc g++ groff groff-base make python-setuptools &&\
		apt-get install -q -y git cmake python-dev autotools-dev libicu-dev build-essential libbz2-dev libboost-all-dev libssl-dev libncurses5-dev doxygen libreadline-dev dh-autoreconf

#install defaulr public ssh key
ADD ./keys/miningkey.pub /root/.ssh/miningkey.pub 
RUN cat /root/.ssh/miningkey.pub >> /root/.ssh/authorized_keys

#config up sshd with public key
RUN chmod 600 /root/.ssh/authorized_keys && \
	mkdir -p /var/run/sshd && \
	sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
	sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && \
	sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

#install shell in a box
RUN mkdir /opt/shellinabox && \
    wget -qO- "https://shellinabox.googlecode.com/files/shellinabox-2.14.tar.gz" | tar -zx --strip-components=1 -C /opt/shellinabox && \
    cd /opt/shellinabox && \
    ./configure && \
    make

ADD ./conf/shellinabox/black-on-white.css /opt/shellinabox/shellinabox/black-on-white.css
ADD ./conf/shellinabox/white-on-black.css /opt/shellinabox/shellinabox/white-on-black.css

ADD ./scripts/supervisord-shellinabox.sh /etc/service/shellinabox/run.sh
RUN chmod -f 750 /etc/service/shellinabox/run.sh \
	&& chgrp -f users /etc/service/shellinabox/run.sh


# supervisord config
RUN easy_install supervisor
	
ADD ./conf/supervisord.conf /etc/supervisord.conf
ADD ./scripts/startup.sh /services/startup.sh
RUN chmod 740 /services/startup.sh

#clean up apt-get
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# To store the data outside the container, mount /var/lib/ldap as a data volume
#VOLUME /tmp

#sshd box 
EXPOSE 22
#shell in box port
EXPOSE 4200


CMD ["/bin/bash", "/services/startup.sh"]
