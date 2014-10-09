#!/bin/bash
# ModernIEManager



### Some functions ###
# Most of this is taken from http://serverfault.com/a/298312
options=("W8.1-IE11" "W8-IE10" "W7-IE11" "W7-IE10" "W7-IE9" "W7-IE8" "Vista-IE7" "XP-IE8" "XP-IE6")

menu() {
    echo "Avaliable OS/Browser combinations:"
    for i in ${!options[@]}; do 
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
    done
    [[ "$msg" ]] && echo "$msg"; :
}


# Get user to select IE versions they want to download
prompt="Check an option (again to uncheck, ENTER when done): "
while menu && read -rp "$prompt" num && [[ "$num" ]]; do
    [[ "$num" != *[![:digit:]]* ]] && (( num > 0 && num <= ${#options[@]} )) || {
        msg="Invalid option: $num"; continue
    }
    ((num--)); msg="${options[num]} was ${choices[num]:+un}checked"
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
done

printf "Downloading"; msg=" nothing"
for i in ${!options[@]}; do 
    [[ "${choices[i]}" ]] && { printf " %s" "${options[i]}"; msg=""; }
done
echo "$msg"



### Create the Virtualbox directory if it's missing and cd to it ###
mkdir -p $HOME/"VirtualBox VMs/"
cd $HOME/"VirtualBox VMs/"



### Check for required VMs ###

# If the user selected 0, check to see if each archive file exists, if not then add W8.1-IE11 URLs to the list
if [ ${choices[0]} ]
then
    [ ! -e "IE11 - Win8.1/IE11.Win8.1.For.LinuxVirtualBox.part1.sfx" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20140402/VirtualBox/IE11_Win8.1/Linux/IE11.Win8.1.For.LinuxVirtualBox.part1.sfx '
    [ ! -e "IE11 - Win8.1/IE11.Win8.1.For.LinuxVirtualBox.part2.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20140402/VirtualBox/IE11_Win8.1/Linux/IE11.Win8.1.For.LinuxVirtualBox.part2.rar '
    [ ! -e "IE11 - Win8.1/IE11.Win8.1.For.LinuxVirtualBox.part3.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20140402/VirtualBox/IE11_Win8.1/Linux/IE11.Win8.1.For.LinuxVirtualBox.part3.rar '
    [ ! -e "IE11 - Win8.1/IE11.Win8.1.For.LinuxVirtualBox.part4.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20140402/VirtualBox/IE11_Win8.1/Linux/IE11.Win8.1.For.LinuxVirtualBox.part4.rar '
fi

# If the user selected 1, check to see if each archive file exists, if not then add W8-IE10 URLs to the list
if [ ${choices[1]} ]
then
    [ ! -e "IE10 - Win8/IE10.Win8.For.LinuxVirtualBox.part1.sfx" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE10_Win8/Linux/IE10.Win8.For.LinuxVirtualBox.part1.sfx '
    [ ! -e "IE10 - Win8/IE10.Win8.For.LinuxVirtualBox.part2.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE10_Win8/Linux/IE10.Win8.For.LinuxVirtualBox.part2.rar '
    [ ! -e "IE10 - Win8/IE10.Win8.For.LinuxVirtualBox.part3.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE10_Win8/Linux/IE10.Win8.For.LinuxVirtualBox.part3.rar '
    [ ! -e "IE10 - Win8/IE10.Win8.For.LinuxVirtualBox.part4.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE10_Win8/Linux/IE10.Win8.For.LinuxVirtualBox.part4.rar '
    [ ! -e "IE10 - Win8/IE10.Win8.For.LinuxVirtualBox.part5.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE10_Win8/Linux/IE10.Win8.For.LinuxVirtualBox.part5.rar '
fi

# If the user selected 2, check to see if each archive file exists, if not then add W7-IE11 URLs to the list
if [ ${choices[2]} ]
then
    [ ! -e "IE11 - Win7/IE11.Win7.ForLinuxVirtualBox.part1.sfx" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE11_Win7/Linux/IE11.Win7.ForLinuxVirtualBox.part1.sfx '
    [ ! -e "IE11 - Win7/IE11.Win7.ForLinuxVirtualBox.part2.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE11_Win7/Linux/IE11.Win7.ForLinuxVirtualBox.part2.rar '
    [ ! -e "IE11 - Win7/IE11.Win7.ForLinuxVirtualBox.part3.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE11_Win7/Linux/IE11.Win7.ForLinuxVirtualBox.part3.rar '
    [ ! -e "IE11 - Win7/IE11.Win7.ForLinuxVirtualBox.part4.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE11_Win7/Linux/IE11.Win7.ForLinuxVirtualBox.part4.rar '
fi

# If the user selected 3, check to see if each archive file exists, if not then add W7-IE10 URLs to the list
if [ ${choices[3]} ]
then
    [ ! -e "IE10 - Win7/IE10.Win7.For.LinuxVirtualBox.part1.sfx" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE10_Win7/Linux/IE10.Win7.For.LinuxVirtualBox.part1.sfx '
    [ ! -e "IE10 - Win7/IE10.Win7.For.LinuxVirtualBox.part2.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE10_Win7/Linux/IE10.Win7.For.LinuxVirtualBox.part2.rar '
    [ ! -e "IE10 - Win7/IE10.Win7.For.LinuxVirtualBox.part3.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE10_Win7/Linux/IE10.Win7.For.LinuxVirtualBox.part3.rar '
    [ ! -e "IE10 - Win7/IE10.Win7.For.LinuxVirtualBox.part4.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE10_Win7/Linux/IE10.Win7.For.LinuxVirtualBox.part4.rar '
fi

# If the user selected 4, check to see if each archive file exists, if not then add W7-IE9 URLs to the list
if [ ${choices[4]} ]
then
    [ ! -e "IE9 - Win7/IE9.Win7.For.LinuxVirtualBox.part1.sfx" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE9_Win7/Linux/IE9.Win7.For.LinuxVirtualBox.part1.sfx '
    [ ! -e "IE9 - Win7/IE9.Win7.For.LinuxVirtualBox.part2.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE9_Win7/Linux/IE9.Win7.For.LinuxVirtualBox.part2.rar '
    [ ! -e "IE9 - Win7/IE9.Win7.For.LinuxVirtualBox.part3.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE9_Win7/Linux/IE9.Win7.For.LinuxVirtualBox.part3.rar '
    [ ! -e "IE9 - Win7/IE9.Win7.For.LinuxVirtualBox.part4.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE9_Win7/Linux/IE9.Win7.For.LinuxVirtualBox.part4.rar '
fi

# If the user selected 5, check to see if each archive file exists, if not then add W7-IE8 URLs to the list
if [ ${choices[5]} ]
then
    [ ! -e "IE8 - Win7/IE8.Win7.For.LinuxVirtualBox.part1.sfx" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE8_Win7/Linux/IE8.Win7.For.LinuxVirtualBox.part1.sfx '
    [ ! -e "IE8 - Win7/IE8.Win7.For.LinuxVirtualBox.part2.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE8_Win7/Linux/IE8.Win7.For.LinuxVirtualBox.part2.rar '
    [ ! -e "IE8 - Win7/IE8.Win7.For.LinuxVirtualBox.part3.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE8_Win7/Linux/IE8.Win7.For.LinuxVirtualBox.part3.rar '
    [ ! -e "IE8 - Win7/IE8.Win7.For.LinuxVirtualBox.part4.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE8_Win7/Linux/IE8.Win7.For.LinuxVirtualBox.part4.rar '
fi

# If the user selected 6, check to see if each archive file exists, if not then add Vista-IE7 URLs to the list
if [ ${choices[6]} ]
then
    [ ! -e "IE7 - Vista/IE7.Vista.For.LinuxVirtualBox.part1.sfx" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE7_Vista/Linux/IE7.Vista.For.LinuxVirtualBox.part1.sfx '
    [ ! -e "IE7 - Vista/IE7.Vista.For.LinuxVirtualBox.part2.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE7_Vista/Linux/IE7.Vista.For.LinuxVirtualBox.part2.rar '
    [ ! -e "IE7 - Vista/IE7.Vista.For.LinuxVirtualBox.part3.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE7_Vista/Linux/IE7.Vista.For.LinuxVirtualBox.part3.rar '
    [ ! -e "IE7 - Vista/IE7.Vista.For.LinuxVirtualBox.part4.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE7_Vista/Linux/IE7.Vista.For.LinuxVirtualBox.part4.rar '
fi

# If the user selected 7, check to see if each archive file exists, if not then add WinXP-IE8 URLs to the list
if [ ${choices[7]} ]
then
    [ ! -e "IE8 - WinXP/IE8.WinXP.For.LinuxVirtualBox.part1.sfx" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE8_WinXP/Linux/IE8.WinXP.For.LinuxVirtualBox.part1.sfx '
    [ ! -e "IE8 - WinXP/IE8.WinXP.For.LinuxVirtualBox.part2.rar" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE8_WinXP/Linux/IE8.WinXP.For.LinuxVirtualBox.part2.rar '
fi

# If the user selected 8, check to see if each archive file exists, if not then add WinXP-IE6 URLs to the list
if [ ${choices[8]} ]
then
    [ ! -e "IE6 - WinXP/IE6.WinXP.For.LinuxVirtualBox.sfx" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE6_WinXP/Linux/IE6.WinXP.For.LinuxVirtualBox.sfx '
fi

if [ -n "$urls" ]; then
    ### Set off the downloads ###
    echo "==============================="
    echo "Downloading VMs, this can take hours so please be patient"
    echo "==============================="
    echo $urls | xargs -n 1 -P 8 wget
fi

### Extract the VMs ###

# Extract IE11 - Win8.1
if [ ${choices[0]} ]
then
    echo "==============================="
    echo "Extracting IE11 - Win8.1"
    echo "==============================="

    # If the VM already exists, remove it
    VBoxManage unregistervm --delete "IE11 - Win8.1"

    # Make the dir to store the VM if it doesn't exist
    mkdir -p $HOME/"VirtualBox VMs/IE11 - Win8.1/"

    # Change to the VM's directory
    cd $HOME/"VirtualBox VMs/IE11 - Win8.1/"

    # Move the archive files if they were downloaded
    [ ! -e "IE11.Win8.1.For.LinuxVirtualBox.part1.sfx" ] && mv "../IE11.Win8.1.For.LinuxVirtualBox.part1.sfx" .
    [ ! -e "IE11.Win8.1.For.LinuxVirtualBox.part2.rar" ] && mv "../IE11.Win8.1.For.LinuxVirtualBox.part2.rar" .
    [ ! -e "IE11.Win8.1.For.LinuxVirtualBox.part3.rar" ] && mv "../IE11.Win8.1.For.LinuxVirtualBox.part3.rar" .
    [ ! -e "IE11.Win8.1.For.LinuxVirtualBox.part4.rar" ] && mv "../IE11.Win8.1.For.LinuxVirtualBox.part4.rar" .

    # Make sure the sfx is executable
    chmod +x "IE11.Win8.1.For.LinuxVirtualBox.part1.sfx"

    # Extract Win8.1 IE11 if the OVA doesn't exist
    [ ! -e "IE11 - Win8.1.ova" ] && ./IE11.Win8.1.For.LinuxVirtualBox.part1.sfx

    # Import to VirtualBox
    VBoxManage import "IE11 - Win8.1.ova"
fi

# Extract IE10 - Win8
if [ ${choices[1]} ]
then
    echo "==============================="
    echo "Extracting IE10 - Win8"
    echo "==============================="

    # If the VM already exists, remove it
    VBoxManage unregistervm --delete "IE10 - Win8"

    # Make the dir to store the VM if it doesn't exist
    mkdir -p $HOME/"VirtualBox VMs/IE10 - Win8/"

    # Change to the VM's directory
    cd $HOME/"VirtualBox VMs/IE10 - Win8/"

    # Move the archive files if they were downloaded
    [ ! -e "IE10.Win8.For.LinuxVirtualBox.part1.sfx" ] && mv "../IE10.Win8.For.LinuxVirtualBox.part1.sfx" .
    [ ! -e "IE10.Win8.For.LinuxVirtualBox.part2.rar" ] && mv "../IE10.Win8.For.LinuxVirtualBox.part2.rar" .
    [ ! -e "IE10.Win8.For.LinuxVirtualBox.part3.rar" ] && mv "../IE10.Win8.For.LinuxVirtualBox.part3.rar" .
    [ ! -e "IE10.Win8.For.LinuxVirtualBox.part4.rar" ] && mv "../IE10.Win8.For.LinuxVirtualBox.part4.rar" .
    [ ! -e "IE10.Win8.For.LinuxVirtualBox.part5.rar" ] && mv "../IE10.Win8.For.LinuxVirtualBox.part5.rar" .

    # Make sure the sfx is executable
    chmod +x "IE10.Win8.For.LinuxVirtualBox.part1.sfx"

    # Extract Win8.1 IE10 if the OVA doesn't exist
    [ ! -e "IE10 - Win8.ova" ] && ./IE10.Win8.For.LinuxVirtualBox.part1.sfx

    # Import to VirtualBox
    VBoxManage import "IE10 - Win8.ova"
fi

# Extract W7 IE11
if [ ${choices[2]} ]
then
    echo "==============================="
    echo "Extracting IE11 - Win7"
    echo "==============================="

    # If the VM already exists, remove it
    VBoxManage unregistervm --delete "IE11 - Win7"

    # Make the dir to store the VM if it doesn't exist
    mkdir -p $HOME/"VirtualBox VMs/IE11 - Win7/"

    # Change to the VM's directory
    cd $HOME/"VirtualBox VMs/IE11 - Win7/"

    # Move the archive files if they were downloaded
    [ ! -e "IE11.Win7.ForLinuxVirtualBox.part1.sfx" ] && mv "../IE11.Win7.ForLinuxVirtualBox.part1.sfx" .
    [ ! -e "IE11.Win7.ForLinuxVirtualBox.part2.rar" ] && mv "../IE11.Win7.ForLinuxVirtualBox.part2.rar" .
    [ ! -e "IE11.Win7.ForLinuxVirtualBox.part3.rar" ] && mv "../IE11.Win7.ForLinuxVirtualBox.part3.rar" .
    [ ! -e "IE11.Win7.ForLinuxVirtualBox.part4.rar" ] && mv "../IE11.Win7.ForLinuxVirtualBox.part4.rar" .

    # Make sure the sfx is executable
    chmod +x "IE11.Win7.ForLinuxVirtualBox.part1.sfx"

    # Extract Win7 IE11 if the OVA doesn't exist
    [ ! -e "IE11 - Win7.ova" ] && ./IE11.Win7.ForLinuxVirtualBox.part1.sfx

    # Import to VirtualBox
    VBoxManage import "IE11 - Win7.ova"
fi

# Extract W7 IE10
if [ ${choices[3]} ]
then
    echo "==============================="
    echo "Extracting IE10 - Win7"
    echo "==============================="

    # If the VM already exists, remove it
    VBoxManage unregistervm --delete "IE10 - Win7"

    # Make the dir to store the VM if it doesn't exist
    mkdir -p $HOME/"VirtualBox VMs/IE10 - Win7/"

    # Change to the VM's directory
    cd $HOME/"VirtualBox VMs/IE10 - Win7/"

    # Move the archive files if they were downloaded
    [ ! -e "IE10.Win7.For.LinuxVirtualBox.part1.sfx" ] && mv "../IE10.Win7.For.LinuxVirtualBox.part1.sfx" .
    [ ! -e "IE10.Win7.For.LinuxVirtualBox.part2.rar" ] && mv "../IE10.Win7.For.LinuxVirtualBox.part2.rar" .
    [ ! -e "IE10.Win7.For.LinuxVirtualBox.part3.rar" ] && mv "../IE10.Win7.For.LinuxVirtualBox.part3.rar" .
    [ ! -e "IE10.Win7.For.LinuxVirtualBox.part4.rar" ] && mv "../IE10.Win7.For.LinuxVirtualBox.part4.rar" .

    # Make sure the sfx is executable
    chmod +x "IE10.Win7.For.LinuxVirtualBox.part1.sfx"

    # Extract Win7 IE10 if the OVA doesn't exist
    [ ! -e "IE10 - Win7.ova" ] && ./IE10.Win7.For.LinuxVirtualBox.part1.sfx


    # Import to VirtualBox
    VBoxManage import "IE10 - Win7.ova"
fi

# Extract W7 IE9
if [ ${choices[4]} ]
then
    echo "==============================="
    echo "Extracting IE9 - Win7"
    echo "==============================="

    # If the VM already exists, remove it
    VBoxManage unregistervm --delete "IE9 - Win7"

    # Make the dir to store the VM if it doesn't exist
    mkdir -p $HOME/"VirtualBox VMs/IE9 - Win7/"

    # Change to the VM's directory
    cd $HOME/"VirtualBox VMs/IE9 - Win7/"

    # Move the archive files if they were downloaded
    [ ! -e "IE9.Win7.For.LinuxVirtualBox.part1.sfx" ] && mv "../IE9.Win7.For.LinuxVirtualBox.part1.sfx" .
    [ ! -e "IE9.Win7.For.LinuxVirtualBox.part2.rar" ] && mv "../IE9.Win7.For.LinuxVirtualBox.part2.rar" .
    [ ! -e "IE9.Win7.For.LinuxVirtualBox.part3.rar" ] && mv "../IE9.Win7.For.LinuxVirtualBox.part3.rar" .
    [ ! -e "IE9.Win7.For.LinuxVirtualBox.part4.rar" ] && mv "../IE9.Win7.For.LinuxVirtualBox.part4.rar" .

    # Make sure the sfx is executable
    chmod +x "IE9.Win7.For.LinuxVirtualBox.part1.sfx"

    # Extract Win7 IE9 if the OVA doesn't exist
    [ ! -e "IE9 - Win7.ova" ] && ./IE9.Win7.For.LinuxVirtualBox.part1.sfx

    # Import to VirtualBox
    VBoxManage import "IE9 - Win7.ova"
fi

# Extract W7 IE8
if [ ${choices[5]} ]
then
    echo "==============================="
    echo "Extracting IE8 - Win7"
    echo "==============================="

    # If the VM already exists, remove it
    VBoxManage unregistervm --delete "IE8 - Win7"

    # Make the dir to store the VM if it doesn't exist
    mkdir -p $HOME/"VirtualBox VMs/IE8 - Win7/"

    # Change to the VM's directory
    cd $HOME/"VirtualBox VMs/IE8 - Win7/"

    # Move the archive files if they were downloaded
    [ ! -e "IE8.Win7.For.LinuxVirtualBox.part1.sfx" ] && mv "../IE8.Win7.For.LinuxVirtualBox.part1.sfx" .
    [ ! -e "IE8.Win7.For.LinuxVirtualBox.part2.rar" ] && mv "../IE8.Win7.For.LinuxVirtualBox.part2.rar" .
    [ ! -e "IE8.Win7.For.LinuxVirtualBox.part3.rar" ] && mv "../IE8.Win7.For.LinuxVirtualBox.part3.rar" .
    [ ! -e "IE8.Win7.For.LinuxVirtualBox.part4.rar" ] && mv "../IE8.Win7.For.LinuxVirtualBox.part4.rar" .

    # Make sure the sfx is executable
    chmod +x "IE8.Win7.For.LinuxVirtualBox.part1.sfx"

    # Extract Win7 IE8 if the OVA doesn't exist
    [ ! -e "IE8 - Win7.ova" ] && ./IE8.Win7.For.LinuxVirtualBox.part1.sfx

    # Import to VirtualBox
    VBoxManage import "IE8 - Win7.ova"
fi

# Extract Vista IE7
if [ ${choices[6]} ]
then
    echo "==============================="
    echo "Extracting IE7 - Vista"
    echo "==============================="

    # If the VM already exists, remove it
    VBoxManage unregistervm --delete "IE7 - Vista"

    # Make the dir to store the VM if it doesn't exist
    mkdir -p $HOME/"VirtualBox VMs/IE7 - Vista/"

    # Change to the VM's directory
    cd $HOME/"VirtualBox VMs/IE7 - Vista/"

    # Move the archive files if they were downloaded
    [ ! -e "IE7.Vista.For.LinuxVirtualBox.part1.sfx" ] && mv "../IE7.Vista.For.LinuxVirtualBox.part1.sfx" .
    [ ! -e "IE7.Vista.For.LinuxVirtualBox.part2.rar" ] && mv "../IE7.Vista.For.LinuxVirtualBox.part2.rar" .
    [ ! -e "IE7.Vista.For.LinuxVirtualBox.part3.rar" ] && mv "../IE7.Vista.For.LinuxVirtualBox.part3.rar" .
    [ ! -e "IE7.Vista.For.LinuxVirtualBox.part4.rar" ] && mv "../IE7.Vista.For.LinuxVirtualBox.part4.rar" .

    # Make sure the sfx is executable
    chmod +x "IE7.Vista.For.LinuxVirtualBox.part1.sfx"

    # Extract Vista IE7 if the OVA doesn't exist
    [ ! -e "IE7 - Vista.ova" ] && ./IE7.Vista.For.LinuxVirtualBox.part1.sfx

    # Import to VirtualBox
    VBoxManage import "IE7 - Vista.ova"
fi

# Extract WinXP IE8
if [ ${choices[7]} ]
then
    echo "==============================="
    echo "Extracting IE8 - WinXP"
    echo "==============================="

    # If the VM already exists, remove it
    VBoxManage unregistervm --delete "IE8 - WinXP"

    # Make the dir to store the VM if it doesn't exist
    mkdir -p $HOME/"VirtualBox VMs/IE8 - WinXP/"

    # Change to the VM's directory
    cd $HOME/"VirtualBox VMs/IE8 - WinXP/"

    # Move the archive files if they were downloaded
    [ ! -e "IE8.WinXP.For.LinuxVirtualBox.part1.sfx" ] && mv "../IE8.WinXP.For.LinuxVirtualBox.part1.sfx" .
    [ ! -e "IE8.WinXP.For.LinuxVirtualBox.part2.rar" ] && mv "../IE8.WinXP.For.LinuxVirtualBox.part2.rar" .

    # Make sure the sfx is executable
    chmod +x "IE8.WinXP.For.LinuxVirtualBox.part1.sfx"

    # Extract WinXP IE8 if the OVA doesn't exist
    [ ! -e "IE8 - WinXP.ova" ] && ./IE8.WinXP.For.LinuxVirtualBox.part1.sfx

    # Import to VirtualBox
    VBoxManage import "IE8 - WinXP.ova"
fi

# Extract WinXP IE6
if [ ${choices[8]} ]
then
    echo "==============================="
    echo "Extracting IE6 - WinXP"
    echo "==============================="

    # If the VM already exists, remove it
    VBoxManage unregistervm --delete "IE6 - WinXP"

    # Make the dir to store the VM if it doesn't exist
    mkdir -p $HOME/"VirtualBox VMs/IE6 - WinXP/"

    # Change to the VM's directory
    cd $HOME/"VirtualBox VMs/IE6 - WinXP/"

    # Move the archive files if they were downloaded
    [ ! -e "IE6.WinXP.For.LinuxVirtualBox.sfx" ] && mv "../IE6.WinXP.For.LinuxVirtualBox.sfx" .

    # Make sure the sfx is executable
    chmod +x "IE6.WinXP.For.LinuxVirtualBox.sfx"

    # Extract WinXP IE8 if the OVA doesn't exist
    [ ! -e "IE6 - WinXP.ova" ] && ./IE6.WinXP.For.LinuxVirtualBox.sfx

    # Import to VirtualBox
    VBoxManage import "IE6 - WinXP.ova"
fi
