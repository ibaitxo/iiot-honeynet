#=========================================================================================
# Alumno: Ibai Castañon Osorio
# Email: icasto01@estudiantes.unileon.es
#
# File config for gateway emulated device
#=========================================================================================
FROM ubuntu:18.04

EXPOSE 22 80 1883

RUN apt-get update

RUN apt-get install -y \
    net-tools \
    nano \
    iptables \ 
    iptables-dev \
    pkg-config \
    supervisor \
    openssh-server \
    openssh-client \
    apache2 \
    nmap \
    ufw \
    mosquitto \
    mosquitto-clients \
    python3-dev \
    python3-pip \
    libglib2.0-dev \
    git \
    telnet \
    wget \
    rsyslog

RUN mkdir /var/run/sshd
RUN mkdir /var/log/sshd
RUN touch /var/log/sshd/sshderr.log 
RUN touch /var/log/sshd/sshd.log 
COPY ./config/syslog-ng.conf /etc/syslog-ng/

RUN echo "root:root" | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#SyslogFacility AUTH/SyslogFacility AUTH/g' /etc/ssh/sshd_config
RUN sed -ri 's/#LogLevel INFO/LogLevel VERBOSE/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instalacion de mailcatcher
RUN apt-get update && apt-get install -y \
    build-essential \
    libsqlite3-dev \
    ruby-dev

# Instalacion
RUN gem install mailcatcher --no-ri --no-rdoc

# expose ports
EXPOSE 1025 1080


COPY ./start-gw.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-gw.sh

# Configuracion de supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Inicio del servicio supervisor
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf