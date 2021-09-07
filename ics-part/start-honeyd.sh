#=========================================================================================
# Alumno: Ibai Castañon Osorio
# Email: icasto01@estudiantes.unileon.es
#
# ICS-Honeyd startup script
#=========================================================================================
#!/bin/bash

cd /home/admin/Honeyd/
touch /home/admin/Honeyd/logs/honeyd.log
sudo ./autogen.sh && ./configure && make && make install
sudo chmod 777 logs/honeyd.log
sudo ./honeyd -d -p nmap-os-db -f iiot-honey.conf -l logs/honeyd.log
