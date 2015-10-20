ModernIEManager
===============

This inventively titled application is a simple shell script for downloading modern.IE virtual machines and extracting them.

## Requirements ##
* Linux (Written and tested on Xubuntu)
* wget
* bash
* VirtualBox

## Downloaded Archive ##
The script will download the .zip files to the vm-archive directory within this repo, so you can copy these between computers easily to save downloading again

## Recommended Setup ##
If you are logged in with a user which has an encrypted home directory, you may well encounter performance issues. To avoid this I recommend configuring VirtualBox to store the imported VMs elsewhere on your hard drive, just make sure the directory you create is owned by your current user.
