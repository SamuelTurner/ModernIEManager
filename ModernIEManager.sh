#!/bin/bash
# ModernIEManager

### Setup Params ###

displayNames=()
zipNames=()
ovaNames=()
urls=()
archiveDir="vm-archive"

# Add details for Windows 10 - Edge & IE11
displayNames[0]="MSEdge - Win10"
zipNames[0]="MSEdge.Win10.VirtualBox.zip"
ovaNames[0]="MSEdge - Win10.ova"
urls[0]="https://az792536.vo.msecnd.net/vms/VMBuild_20190311/VirtualBox/MSEdge/MSEdge.Win10.VirtualBox.zip"

### Declare Helper Functions ###
menu() {
    clear
    echo "Avaliable OS/Browser combinations:"
    for i in ${!displayNames[@]}; do
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${displayNames[i]}"
    done
    [[ "$msg" ]] && echo "$msg"; :
}

### Ask user to specify VMs to set up ###
prompt="Check an option (again to uncheck, ENTER when done): "
while menu && read -rp "$prompt" num && [[ "$num" ]]; do
    [[ "$num" != *[![:digit:]]* ]] && (( num > 0 && num <= ${#displayNames[@]} )) || {
        msg="Invalid option: $num"; continue
    }
    ((num--)); msg="${displayNames[num]} was ${choices[num]:+un}checked"
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
done

### Download missing VM archives ###
cd $archiveDir

for i in "${!choices[@]}"; do
  printf "%s\t%s\n" "$i" "${choices[$i]}"

  [ ! -e "${zipNames[i]}" ] && downloads+="${urls[i]} "
done

if [ -n "$downloads" ]; then
    echo "==============================="
    echo "Downloading VMs, this can take hours so please be patient"
    echo "==============================="
    echo $downloads | xargs -n 1 -P 8 wget
fi

### Remove existing VMs ###
for i in "${!choices[@]}"; do
    if [ $(vboxmanage list vms | grep -c "${displayNames[i]}") -gt 0 ]; then
        echo "==============================="
        echo "Deleting ${displayNames[i]}"
        echo "==============================="
        VBoxManage unregistervm --delete "${displayNames[i]}"
    fi
done

### Extract the OVAs ###
for i in "${!choices[@]}"; do
    if [ ! -e "${ovaNames[i]}" ]; then
        echo "==============================="
        echo "Extracting ${displayNames[i]}"
        echo "==============================="
        unzip "${zipNames[i]}"
    fi
done

### Import the OVAs ###
for i in "${!choices[@]}"; do
    VBoxManage import "${ovaNames[i]}"
done

cd ../
