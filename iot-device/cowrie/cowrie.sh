#=========================================================================================
# Alumno: Ibai Castañon Osorio
# Email: icasto01@estudiantes.unileon.es
#
# Descripcion: Fichero de arranque de cowrie
#=========================================================================================
#!/bin/bash

#iptables -t nat -A PREROUTING -p tcp --dport 22 -j REDIRECT --to-port 2222
#iptables -t nat -A PREROUTING -p tcp --dport 23 -j REDIRECT --to-port 2223

sudo chmod 777 /home/iot/cowrie/var/log/cowrie
sudo chmod 777 /home/iot/cowrie/var/lib/cowrie
sudo -u iot -H sh -c "./home/iot/cowrie/bin/cowrie start" 
sudo mkdir /home/iot/cowrie/var/lib/cowrie/downloads
sudo mkdir /home/iot/cowrie/var/lib/cowrie/snapshots
sudo mkdir /home/iot/cowrie/var/lib/cowrie/tty
sudo chmod 777 /home/iot/cowrie/var/lib/cowrie/downloads
sudo chmod 777 /home/iot/cowrie/var/lib/cowrie/snapshots
sudo chmod 777 /home/iot/cowrie/var/lib/cowrie/tty
sudo -u iot -H sh -c service ssh restart