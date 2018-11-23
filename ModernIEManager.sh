#!/bin/bash
# ModernIEManager

### Some functions ###
# Most of this is taken from http://serverfault.com/a/298312
options=("W10-Edge" "W8.1-IE11" "W7-IE11" "W7-IE10" "W7-IE9" "W7-IE8")

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
cd "vm-archive"

### If VM archives missing, add to download list ###
if [ ${choices[0]} ]
then
    [ ! -e "MSEdge.Win10.VirtualBox.zip" ] && urls+='https://az792536.vo.msecnd.net/vms/VMBuild_20180425/VirtualBox/MSEdge/MSEdge.Win10.VirtualBox.zip '
fi

if [ ${choices[1]} ]
then
    [ ! -e "IE11.Win81.VirtualBox.zip" ] && urls+='https://az792536.vo.msecnd.net/vms/VMBuild_20180102/VirtualBox/IE11/IE11.Win81.VirtualBox.zip '
fi

if [ ${choices[2]} ]
then
    [ ! -e "IE11.Win7.VirtualBox.zip" ] && urls+='https://az792536.vo.msecnd.net/vms/VMBuild_20180102/VirtualBox/IE11/IE11.Win7.VirtualBox.zip '
fi

if [ ${choices[3]} ]
then
    [ ! -e "IE10.Win7.VirtualBox.zip" ] && urls+='https://az792536.vo.msecnd.net/vms/VMBuild_20150916/VirtualBox/IE10/IE10.Win7.VirtualBox.zip '
fi

if [ ${choices[4]} ]
then
    [ ! -e "IE9.Win7.VirtualBox.zip" ] && urls+='https://az792536.vo.msecnd.net/vms/VMBuild_20150916/VirtualBox/IE9/IE9.Win7.VirtualBox.zip '
fi

if [ ${choices[5]} ]
then
    [ ! -e "IE8.Win7.VirtualBox.zip" ] && urls+='https://az792536.vo.msecnd.net/vms/VMBuild_20150916/VirtualBox/IE8/IE8.Win7.VirtualBox.zip '
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

  # Remove the VM
  VBoxManage unregistervm --delete "IE11 - Win10"

  # Extract OVA
  [ ! -e "MSEdge - Win10.ova" ] && unzip 'MSEdge.Win10.VirtualBox.zip'

  # Import to VirtualBox
  VBoxManage import "MSEdge - Win10.ova"

  # Remove the OVA
  rm "MSEdge - Win10.ova"
fi

# Extract IE11 - Win8.1
if [ ${choices[1]} ]
then
    echo "==============================="
    echo "Extracting IE11 - Win8.1"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE11 - Win8.1"

    # Extract OVA
    [ ! -e "IE11 - Win81.ova" ] && unzip 'IE11.Win81.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE11 - Win81.ova"

    # Remove the OVA
    rm "IE11 - Win81.ova"
fi

# Extract W7 IE11
if [ ${choices[2]} ]
then
    echo "==============================="
    echo "Extracting IE11 - Win7"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE11 - Win7"

    # Extract OVA
    [ ! -e "IE11 - Win7.ova" ] && unzip 'IE11.Win7.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE11 - Win7.ova"

    # Remove the OVA
    rm "IE11 - Win7.ova"
fi

# Extract W7 IE10
if [ ${choices[3]} ]
then
    echo "==============================="
    echo "Extracting IE10 - Win7"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE10 - Win7"

    # Extract OVA
    [ ! -e "IE10 - Win7.ova" ] && unzip 'IE10.Win7.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE10 - Win7.ova"

    # Remove the OVA
    rm "IE10 - Win7.ova"
fi

# Extract W7 IE9
if [ ${choices[4]} ]
then
    echo "==============================="
    echo "Extracting IE9 - Win7"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE9 - Win7"

    # Extract OVA
    [ ! -e "IE9 - Win7.ova" ] && unzip 'IE9.Win7.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE9 - Win7.ova"

    # Remove the OVA
    rm "IE9 - Win7.ova"
fi

# Extract W7 IE8
if [ ${choices[5]} ]
then
    echo "==============================="
    echo "Extracting IE8 - Win7"
    echo "==============================="

    # Setup
    VBoxManage unregistervm --delete "IE8 - Win7"

    # Extract OVA
    [ ! -e "IE8 - Win7.ova" ] && unzip 'IE8.Win7.VirtualBox.zip'

    # Import to VirtualBox
    VBoxManage import "IE8 - Win7.ova"

    # Remove the OVA
    rm "IE8 - Win7.ova"
fi
