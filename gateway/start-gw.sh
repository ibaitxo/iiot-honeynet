#=========================================================================================
# Alumno: Ibai Castañon Osorio
# Email: icasto01@estudiantes.unileon.es
#
# Gateway startup script
#=========================================================================================
#!/bin/bash

# Arranque de SSH
service ssh start
mailcatcher -f --ip=0.0.0.0