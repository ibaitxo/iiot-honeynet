#=========================================================================================
# Alumno: Ibai Castañon Osorio
# Email: icasto01@estudiantes.unileon.es
#
# Script for submit malware samples to CAPEv2
#=========================================================================================
#!/bin/bash

function submit {
    MUESTRAS_PATH="/home/$USER/honeynet/muestras/downloads"
    BIBLIOTECA_PATH="/home/$USER/honeynet/BibliotecaMuestras"

    if [ -n "$(find $MUESTRAS_PATH -prune -empty 2>/dev/null)" ]
    then
        echo "empty (directory or file)"
    else
        cd $MUESTRAS_PATH
        files=(*)
        /usr/bin/cp $files $BIBLIOTECA_PATH
        rm $files
        cd $BIBLIOTECA_PATH
        /usr/bin/python3 /home/$USER/CAPEv2/utils/submit.py $files
    fi
}

# Check if cuckoo is running
if ps axu | grep "[p]ython3 cuckoo.py" > /dev/null
then
    python3 ~/CAPEv2/cuckoo.py &
    submit
else
    submit
fi





