ModernIEManager
===============

This inventively titled application is a simple shell script for downloading modern.IE virtual machines and extracting them.

## Requirements ##
* Linux (Written and tested on Xubuntu)
* wget
* bash
* VirtualBox

## Setup ##
This script intends for the VMs to run from a /home/ModernIEVMs/ directory, to avoid running the VMs in the user's home directory because doing that when the home directory is encrypted kills VM performance.

In order for this to work, you need to create that directory and change the owner so that the script can edit it:

    sudo mkdir /home/ModernIEVMs/ && sudo chown $USER:$USER /home/ModernIEVMs/
