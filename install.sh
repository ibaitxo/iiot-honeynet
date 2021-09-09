#=========================================================================================
# Alumno: Ibai Castañon Osorio
# Email: icasto01@estudiantes.unileon.es
#
# Configuration script needed for setting different parameters used in malware analysis
# system.
#=========================================================================================
#!/bin/bash

echo "[*] Starting config file..."
sleep 2

echo "[-] Configuring host only interface"
# Host-Only configuration
sudo chmod +x ./config/vboxhostonly
sudo [ -d /opt/systemd/  ] || sudo mkdir /opt/systemd/
sudo cp ./config/vboxhostonly /opt/systemd/
sudo cp ./config/vboxhostonlynic.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable vboxhostonlynic.service

echo '[-] Creating library folder for samples'
sleep 2
# Make dir for malware samples
[ -d /home/$USER/honeynet/BibliotecaMuestras  ] || mkdir /home/$USER/honeynet/BibliotecaMuestras 

echo '[-] Configuring crontab jobs for root'
sleep 2
# Configure sudo crontab
echo '@reboot /usr/bin/python3 ~/CAPEv2/utils/rooter.py' >> root_cron
echo '@reboot /bin/mkdir -p /data/configdb && /bin/mkdir -p /data/db && /bin/chown mongodb:mongodb /data -R' >> root_cron
echo '15 * * * * /usr/bin/suricata-update --suricata /usr/bin/suricata --suricata-conf /etc/suricata/suricata.yaml -o /etc/suricata/rules/ && /usr/bin/suricatasc -c reload-rules /tmp/suricata-command.socket &>/dev/nu>' >> root_cron
echo '@reboot cd /opt/CAPEv2/utils/ && ./smtp_sinkhole.sh 2>/dev/null' >> root_cron 
echo '5 */3 * * * cd /opt/CAPEv2/utils/ && python3 community.py -waf -cr && pip3 install -U flare-capa  && systemctl restart cape-processor 2>/dev/null' >> root_cron
echo '00 */1 * * * (echo authenticate ''; echo signal newnym; echo quit) | nc localhost 9051 2>/dev/null' >> root_cron
echo '15 * * * * /usr/bin/suricata-update --suricata /usr/bin/suricata --suricata-conf /etc/suricata/suricata.yaml -o /etc/suricata/rules/ && /usr/bin/suricatasc -c reload-rules /tmp/suricata-command.socket &>/dev/nu>'>> root_cron
sudo crontab -u root root_cron
rm root_cron

echo '[-] Configuring crontab jobs for user'
sleep 2
# Configure crontab
echo '@reboot /usr/bin/python3 ~/CAPEv2/cuckoo.py'  >> user_cron
echo '@reboot /usr/bin/python3 ~/CAPEv2/utils/process.py -p4 auto'  >> user_cron
# Configure crontab for sending malware to CAPEv2 every 5 minutes
echo '*/5 * * * * /bin/bash ~/honeynet/submit_sample.sh'  >> user_cron
crontab -u $USER user_cron
rm user_cron

echo '[-] Copying submit malware script to ~/honeynet/'
cp submit_sample.sh ~/honeynet/
chmod +x submit_sample.sh

echo '[+] Configuration finished, you must reboot your system!'
sleep 3
