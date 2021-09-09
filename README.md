# IIoT Honeynet
System created to emulate a honeynet based on an industrial IIoT network for capturing malware samples.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## Installation
The system has been created by containerizing the different honeypots together with the ELK. The repository needs to be cloned and the containers need to be up.

* Clone this repo: git clone https://github.com/ibaitxo/iiot-honeynet.
* Give execute permissions to the install.sh script and execute it.
```bash
chomd +x install.sh
./install.sh
```

Once these steps have been performed, the installation is complete.

## Usage
To start the honeynet, simply start the containers. To do this, from the directory where the docker-compose.yml file is located, the following command is executed:

```bash
docker-compose up
```
If the images have not been created, before the containers start working, their images will be created automatically.

## License
GNU General Public License v3.0

