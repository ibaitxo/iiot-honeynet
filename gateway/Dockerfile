#=========================================================================================
# Alumno: Ibai Castañon Osorio
# Email: icasto01@estudiantes.unileon.es
#
# Descripcion: Fichero de configuracion de Dockerfile para firewall
#
#=========================================================================================
FROM ubuntu:18.04

EXPOSE 22 80 1883

RUN apt-get update

RUN apt-get install -y \
    iproute2 \
    net-tools \
    iputils-ping\
    traceroute \
    nano \
    iptables \ 
    iptables-dev \
    pkg-config \
    supervisor \
    openssh-server \
    openssh-client \
    apache2 \
    xinetd \
    nmap \
    syslog-ng \
    ufw \
    mosquitto \
    mosquitto-clients 

RUN mkdir /var/run/sshd
RUN mkdir /var/log/sshd
RUN touch /var/log/sshd/sshderr.log 
RUN touch /var/log/sshd/sshd.log 
COPY ./config/syslog-ng.conf /etc/syslog-ng/

RUN echo "root:root" | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./start-gw.sh .
RUN chmod +x start-gw.sh

# Configuracion de supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Inicio del servicio supervisor
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf