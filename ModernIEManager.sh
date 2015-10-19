#!/bin/bash
# ModernIEManager

### Some functions ###
# Most of this is taken from http://serverfault.com/a/298312
options=("W10-Edge" "W8.1-IE11" "W8-IE10" "W7-IE11" "W7-IE10" "W7-IE9" "W7-IE8" "Vista-IE7" "XP-IE8" "XP-IE6")

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



### Setup ###
VBDIR="/home/ModernIEVMs/"
cd $VBDIR

### If VM archives missing, add to download list ###
if [ ${choices[0]} ]
  then
    [ ! -e "Edge - Win10/Microsoft Edge.Win10.For.Windows.VirtualBox.zip" ] && urls+='https://az792536.vo.msecnd.net/vms/VMBuild_20150801/VirtualBox/MSEdge/Windows/Microsoft%20Edge.Win10.For.Windows.VirtualBox.zip '
fi

if [ ${choices[1]} ]
then
    [ ! -e "IE11 - Win8.1/IE11.Win8.1.For.Windows.VirtualBox.zip" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20141027/VirtualBox/IE11/Windows/IE11.Win8.1.For.Windows.VirtualBox.zip '
fi

if [ ${choices[2]} ]
then
    [ ! -e "IE10 - Win8/IE10.Win8.For.Windows.VirtualBox.zip" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20141027/VirtualBox/IE10/Windows/IE10.Win8.For.Windows.VirtualBox.zip '
fi

if [ ${choices[3]} ]
then
    [ ! -e "IE11 - Win7/IE11.Win7.For.Windows.VirtualBox.zip" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20141027/VirtualBox/IE11/Windows/IE11.Win7.For.Windows.VirtualBox.zip '
fi

if [ ${choices[4]} ]
then
    [ ! -e "IE10 - Win7/IE10.Win7.For.Windows.VirtualBox.zip" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20141027/VirtualBox/IE10/Windows/IE10.Win7.For.Windows.VirtualBox.zip '
fi

if [ ${choices[5]} ]
then
    [ ! -e "IE9 - Win7/IE9.Win7.For.Windows.VirtualBox.zip" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20141027/VirtualBox/IE9/Windows/IE9.Win7.For.Windows.VirtualBox.zip '
fi

if [ ${choices[6]} ]
then
    [ ! -e "IE8 - Win7/IE8.Win7.For.Windows.VirtualBox.zip" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20141027/VirtualBox/IE8/Windows/IE8.Win7.For.Windows.VirtualBox.zip '
fi

if [ ${choices[7]} ]
then
    [ ! -e "IE7 - Vista/IE7.Vista.For.Windows.VirtualBox.zip" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20141027/VirtualBox/IE7/Windows/IE7.Vista.For.Windows.VirtualBox.zip '
fi

if [ ${choices[8]} ]
then
    [ ! -e "IE8 - WinXP/IE8.XP.For.Windows.VirtualBox.zip" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20141027/VirtualBox/IE8/Windows/IE8.XP.For.Windows.VirtualBox.zip '
fi

if [ ${choices[9]} ]
then
    [ ! -e "IE6 - WinXP/IE6.XP.For.Windows.VirtualBox.zip" ] && urls+='https://az412801.vo.msecnd.net/vhd/VMBuild_20141027/VirtualBox/IE6/Windows/IE6.XP.For.Windows.VirtualBox.zip '
fi

### Download things if needed ###
if [ -n "$urls" ]; then
    echo "==============================="
    echo "Downloading VMs, this can take hours so please be patient"
    echo "==============================="
    echo $urls | xargs -n 1 -P 8 wget
fi

### Extract the VMs ###
if [ ${choices[0]} ]
  then
  echo "==============================="
  echo "Extracting Edge - Win10"
  echo "==============================="

  # Setup
  VBoxManage unregistervm --delete "IE11 - Win10"
  mkdir -p $VBDIR/"Edge - Win10/"
  cd $VBDIR/"Edge - Win10/"

  # Move archive if neeed, extract OVA
  [ ! -e "Microsoft Edge.Win10.For.Windows.VirtualBox.zip" ] && mv "../Microsoft Edge.Win10.For.Windows.VirtualBox.zip" .
  [ ! -e "IE11 - Win10.ova" ] && unzip 'Microsoft Edge.Win10.For.Windows.VirtualBox.zip'

  # Import to VirtualBox
  VBoxManage import "IE11 - Win10.ova"

  # Remove the OVA
  rm "IE11 - Win10.ova"
fi

# Extract IE11 - Win8.1
if [ ${choices[1]} ]
then
    echo "==============================="
    echo "Extracting IE11 - Win8.1"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE11 - Win8.1"
    mkdir -p $VBDIR/"IE11 - Win8.1/"
    cd $VBDIR/"IE11 - Win8.1/"

    # Move archive if needed, extract OVA
    [ ! -e "IE11.Win8.1.For.Windows.VirtualBox.zip" ] && mv "../IE11.Win8.1.For.Windows.VirtualBox.zip" .
    [ ! -e "IE11 - Win8.1.ova" ] && unzip 'IE11.Win8.1.For.Windows.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE11 - Win8.1.ova"

    # Remove the OVA
    rm "IE11 - Win8.1.ova"
fi

# Extract IE10 - Win8
if [ ${choices[2]} ]
then
    echo "==============================="
    echo "Extracting IE10 - Win8"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE10 - Win8"
    mkdir -p $VBDIR/"IE10 - Win8/"
    cd $VBDIR/"IE10 - Win8/"

    # Move the archive files if needed, extract OVA
    [ ! -e "IE10.Win8.For.Windows.VirtualBox.zip" ] && mv "../IE10.Win8.For.Windows.VirtualBox.zip" .
    [ ! -e "IE10 - Win8.ova" ] && unzip 'IE10.Win8.For.Windows.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE10 - Win8.ova"

    # Remove the OVA
    rm "IE10 - Win8.ova"
fi

# Extract W7 IE11
if [ ${choices[3]} ]
then
    echo "==============================="
    echo "Extracting IE11 - Win7"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE11 - Win7"
    mkdir -p $VBDIR/"IE11 - Win7/"
    cd $VBDIR/"IE11 - Win7/"

    # Move the archive files if needed, extract OVA
    [ ! -e "IE11.Win7.For.Windows.VirtualBox.zip" ] && mv "../IE11.Win7.For.Windows.VirtualBox.zip" .
    [ ! -e "IE11 - Win7.ova" ] && unzip 'IE11.Win7.For.Windows.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE11 - Win7.ova"

    # Remove the OVA
    rm "IE11 - Win7.ova"
fi

# Extract W7 IE10
if [ ${choices[4]} ]
then
    echo "==============================="
    echo "Extracting IE10 - Win7"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE10 - Win7"
    mkdir -p $VBDIR/"IE10 - Win7/"
    cd $VBDIR/"IE10 - Win7/"

    # Move the archive files if needed, extract OVA
    [ ! -e "IE10.Win7.For.Windows.VirtualBox.zip" ] && mv "../IE10.Win7.For.Windows.VirtualBox.zip" .
    [ ! -e "IE10 - Win7.ova" ] && unzip 'IE10.Win7.For.Windows.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE10 - Win7.ova"

    # Remove the OVA
    rm "IE10 - Win7.ova"
fi

# Extract W7 IE9
if [ ${choices[5]} ]
then
    echo "==============================="
    echo "Extracting IE9 - Win7"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE9 - Win7"
    mkdir -p $VBDIR/"IE9 - Win7/"
    cd $VBDIR/"IE9 - Win7/"

    # Move the archive files if needed, extract OVA
    [ ! -e "IE9.Win7.For.Windows.VirtualBox.zip" ] && mv "../IE9.Win7.For.Windows.VirtualBox.zip" .
    [ ! -e "IE9 - Win7.ova" ] && unzip 'IE9.Win7.For.Windows.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE9 - Win7.ova"

    # Remove the OVA
    rm "IE9 - Win7.ova"
fi

# Extract W7 IE8
if [ ${choices[6]} ]
then
    echo "==============================="
    echo "Extracting IE8 - Win7"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE8 - Win7"
    mkdir -p $VBDIR/"IE8 - Win7/"
    cd $VBDIR/"IE8 - Win7/"

    # Move the archive files if needed, extract OVA
    [ ! -e "IE8.Win7.For.Windows.VirtualBox.zip" ] && mv "../IE8.Win7.For.Windows.VirtualBox.zip" .
    [ ! -e "IE8 - Win7.ova" ] && unzip 'IE8.Win7.For.Windows.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE8 - Win7.ova"

    # Remove the OVA
    rm "IE8 - Win7.ova"
fi

# Extract Vista IE7
if [ ${choices[7]} ]
then
    echo "==============================="
    echo "Extracting IE7 - Vista"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE7 - Vista"
    mkdir -p $VBDIR/"IE7 - Vista/"
    cd $VBDIR/"IE7 - Vista/"

    # Move the archive files if needed, extract OVA
    [ ! -e "IE7.Vista.For.Windows.VirtualBox.zip" ] && mv "../IE7.Vista.For.Windows.VirtualBox.zip" .
    [ ! -e "IE7 - Vista.ova" ] && unzip 'IE7.Vista.For.Windows.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE7 - Vista.ova"

    # Remove the OVA
    rm "IE7 - Win7.ova"
fi

# Extract WinXP IE8
if [ ${choices[8]} ]
then
    echo "==============================="
    echo "Extracting IE8 - WinXP"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE8 - WinXP"
    mkdir -p $VBDIR/"IE8 - WinXP/"
    cd $VBDIR/"IE8 - WinXP/"

    # Move the archive files if needed, extract OVA
    [ ! -e "IE8.XP.For.Windows.VirtualBox.zip" ] && mv "../IE8.XP.For.Windows.VirtualBox.zip" .
    [ ! -e "IE8 - WinXP.ova" ] && unzip 'IE8.XP.For.Windows.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE8 - WinXP.ova"

    # Remove the OVA
    rm "IE8 - WinXP.ova"
fi

# Extract WinXP IE6
if [ ${choices[9]} ]
then
    echo "==============================="
    echo "Extracting IE6 - WinXP"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE6 - WinXP"
    mkdir -p $VBDIR/"IE6 - WinXP/"
    cd $VBDIR/"IE6 - WinXP/"

    # Move the archive files if needed, extract OVA
    [ ! -e "IE6.XP.For.Windows.VirtualBox.zip" ] && mv "../IE6.XP.For.Windows.VirtualBox.zip" .
    [ ! -e "IE6 - WinXP.ova" ] && unzip 'IE6.XP.For.Windows.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE6 - WinXP.ova"

    # Remove the OVA
    rm "IE6 - WinXP.ova"
fi
