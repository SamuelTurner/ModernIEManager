#!/bin/bash
# ModernIEManager


### Get user to select IE versions they want to download ###
# Most of this is taken from http://serverfault.com/a/298312
options=("W8.1 IE11" "W8 IE10" "W7 IE11" "W7 IE10" "W7 IE9" "W7 IE8" "Vista IE7" "XP IE8" "XP IE6")

menu() {
    echo "Avaliable OS/Browser combinations:"
    for i in ${!options[@]}; do 
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
    done
    [[ "$msg" ]] && echo "$msg"; :
}

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

