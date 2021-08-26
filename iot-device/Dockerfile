#=========================================================================================
# Alumno: Ibai Castañon Osorio
# Email: icasto01@estudiantes.unileon.es
#
# Descripcion: Fichero de configuracion de Dockerfile para dmz
#
#=========================================================================================
FROM ubuntu:18.04

ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1

# Update del contenedor
RUN apt-get update && apt-get install -y \
    iproute2 \
    openssh-server    \
    net-tools \
    iputils-ping \
    traceroute \
    nano \
    iptables \
    iptables-dev \
    pkg-config \
    apache2 \
    supervisor \
    nmap \
    sqlite3 \
    mysql-server \
    mysql-client \
    telnet \
    sudo \
    mosquitto \
    mosquitto-clients 

##############################
# Instalacion de cowrie
##############################

# Dependencias
RUN apt-get update && apt-get install -y \
    python-virtualenv \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev \
    libpython3-dev \
    python3-minimal \
    authbind \
    virtualenv \
    python3-pip \
    git 

# Crear cuenta de usuario
RUN adduser --disabled-password iot

# Descarga de repositorio
RUN su - iot && \
    cd /home/iot && git clone http://github.com/cowrie/cowrie && \
    cd cowrie/ && \
    virtualenv --python=python3 cowrie-env && \
    /bin/bash -c "source cowrie-env/bin/activate" && \
    pip3 install --upgrade pip && \
    pip3 install --upgrade -r requirements.txt

# Solucion al problema de ASCII
USER root
RUN apt-get -y install locales
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8




# Ficheros para cowrie
COPY ./cowrie/cowrie.cfg.dist /home/iot/cowrie/etc/cowrie.cfg
COPY ./cowrie/iotHoney.pickle /home/iot/cowrie/share/cowrie/
ADD ./honeyfs_local /home/iot/cowrie/honeyfs
COPY ./cowrie/userdb.txt home/iot/cowrie/etc/

RUN chown -R iot:iot /home/iot/cowrie
######################################################

RUN mkdir /var/run/sshd

RUN echo "root:root" | chpasswd
COPY ./config/ssh/sshd_config /etc/ssh/

RUN mkdir /root/.ssh
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./cowrie/cowrie.sh .
RUN chmod +x cowrie.sh

COPY ./start-iot.sh .
RUN chmod +x start-iot.sh

# Configuracion de supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Inicio del servicio supervisor
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf