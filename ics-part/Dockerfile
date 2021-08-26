#=========================================================================================
# Alumno: Ibai Castañon Osorio
# Email: icasto01@estudiantes.unileon.es
#
# Descripcion: Fichero de configuracion de Dockerfile para la parte de Honeyd
#
#=========================================================================================
FROM ubuntu:18.04

# Instalaciones comunes para herramientas del contenedor
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    iproute2 \
    net-tools \
    iputils-ping\
    nano \
    pkg-config \
    git \
    supervisor \
    sudo

# Instalacion de dependencias para el uso de Honeyd
RUN apt-get install -y \
    libevent-dev \
    libdumbnet-dev \
    libpcap-dev \
    libpcre3-dev \
    libedit-dev \
    bison flex \
    libtool \
    automake \
    zlib1g \
    zlib1g-dev

# Crear cuenta de usuario
RUN adduser --disabled-password admin

# Descarga de repositorio de Honeyd
RUN su - admin && cd /home/admin && git clone https://github.com/DataSoft/Honeyd

COPY ./config-files/* /home/admin/Honeyd/

COPY ./start-honeyd.sh .
RUN chmod +x start-honeyd.sh

# Configuracion de supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Inicio del servicio supervisor
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
