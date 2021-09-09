#=========================================================================================
# Alumno: Ibai Castañon Osorio
# Email: icasto01@estudiantes.unileon.es
#
# Dockerfile configuration for ELK Stack
#=========================================================================================
FROM ubuntu:18.04

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

EXPOSE 5601 9200 9300 9600 5044

# Instalacion paquetes base
RUN apt-get update && apt-get install -y \
    systemd \
    supervisor \
    gnupg2 \
    wget \
    ca-certificates \
    net-tools \
    sudo \
    nano \
    iptables \
    ufw 

# Instalacion dependencias
RUN set -x \
    && apt-get install -y --no-install-recommends ca-certificates curl gosu tzdata openjdk-11-jdk-headless nginx\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && gosu nobody true \
    && set +x

# Configurar tzdata
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata
RUN dpkg-reconfigure tzdata

# Añadir repositorio de Elastic 
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -\
    && apt-get install apt-transport-https \
    && echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main"  \
    | sudo tee –a /etc/apt/sources.list.d/elastic-7.x.list

# Instalacion de ElasticSearch
RUN apt-get update && apt-get -y install elasticsearch
COPY ./conf/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
RUN chown elasticsearch:elasticsearch /usr/share/elasticsearch
RUN chown -R elasticsearch:elasticsearch /var/lib/elasticsearch/

# Instalacion de Kibana
RUN apt-get install -y kibana
COPY ./conf/kibana/kibana.yml /etc/kibana/kibana.yml

# Instalacion de Logstash
RUN apt-get install -y ruby-dev logstash
RUN gem update --system
COPY ./conf/logstash/logstash /etc/init.d/
COPY ./conf/logstash/logstash.yml /etc/logstash/
COPY ./conf/logstash/logstash.conf /etc/logstash/conf.d
RUN chmod +x /etc/init.d/logstash

# Instalacion de Filebeat
RUN apt-get install filebeat
COPY ./conf/filebeat/filebeat.yml /etc/filebeat/filebeat.yml

COPY ./start-elk.sh /usr/local/bin/start-elk.sh
RUN chmod +x /usr/local/bin/start-elk.sh

# Configuracion de supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Inicio del servicio supervisor
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf