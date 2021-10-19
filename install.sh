#!/bin/bash

# This installer was written by https://github.com/happycodinguk
# Am looking forward to its modification and improvement from the Open Source Community!
# Please leave feedback or message me on telegram https://t.me/joinchat/xlmtm7jVYR4yODQ0
# Make temporary installer folder in /tmp

# -------------------------------------------------------

read -p "
-------------------------------------------------------
          **TELEGRAM-SERVER-MONITOR**
-------------------------------------------------------
INSTALL SCRIPT TESTED ON: 
DEBIAN 10 
CENTOS 7 
You can view all installation files at: 
https://github.com/happycodinguk/telegram-system-monitor
DM to advertise credit for a snippet used or suggest snippet/modification on:
Telegram: https://t.me/joinchat/xlmtm7jVYR4yODQ0

System Requirements for basic install:
wget 
Ubuntu/Debian:  apt install -y wget
CentOS:         yum install -y wget

curl
Ubuntu/Debian   apt install -y curl
CentOS:         yum install -y curl

zip
Ubuntu/Debian   apt install -y zip
CentOS:         yum install -y curl

If you need to install any of these, open a second terminal window and do it now..

OK. Are you ready?

Yes or No?" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

rm -fr -y /tmp/tg_install
mkdir /tmp/tg_install
cd /tmp/tg_install

### Downloading monitor scripts
wget https://github.com/happycodinguk/telegram-system-monitor/archive/refs/heads/main.zip 

unzip main.zip

cd telegram-system-monitor-main

cp install-template.sh installed-choices.sh

read -p "
-------------------------------------------------------

This script will install Telegram BOT Notifications.
Pick one, all, or any combo if these notifications!

-------------------------------
- Postfix Activity Reports
- Low Storage Alerts 
- System Service Failure Alerts 
- CPU and Memory Alerts
- CSF LFD Firewall alerts
- SSH Login alerts (NOT WORKING ON CENTOS YET)
-------------------------------

- You will choose an install location for the scripts (default options avaiable).
- SSH Login alerts will install the script into your chosen location. 
  It will also add a link to trigger the script on SSH login in: 

  /etc/pam.d/sshd    (at the end of the file)
  
- SSH Login alerts option isn't needed if you are running CSF Firewall.
  CSF/LFD sends SSH, webmin login notifications along with IP blocking info etc.

>> Always have a backup of your system or try out in a testing environment<<

Lets compile your install package!
Are you ready?
(Type Y or N)" -n 1 -r

echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

#Menu options
options[0]="Postfix Activity Reporter"
options[1]="Low Storage Alert"
options[2]="System Service Failure Alert"
options[3]="CPU and Memory Alert"
options[4]="CSF LFD Firewall alerts (CSF sends SSH Login notifications by default)"
options[5]="SSH Login alerts (NOT WORKING ON CENTOS YET - This option isnt needed with CSF Firewall installations - CSF Send SSH and other notifications)"

#Actions to take based on selection
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        #Option 1 selected
        echo "Postfix Activity Report         -       *SELECTED*"
      #  cat telegram-inst.txt >> /tmp/custom-install.sh
        sed -i -e '/"postfix"/r postfix-inst.txt' installed-choices.sh
        sleep 1
    fi
    if [[ ${choices[1]} ]]; then
        #Option 2 selected
        echo "Low Storage Alert               -       *SELECTED*"
        sed -i -e '/"storage"/r storage-inst.txt' installed-choices.sh
        sleep 1
    fi
    if [[ ${choices[2]} ]]; then
        #Option 3 selected
        echo "System Service Failure Alert    -       *SELECTED*"
        sed -i -e '/"system"/r system-inst.txt' installed-choices.sh
        sleep 1
    fi
    if [[ ${choices[3]} ]]; then
        #Option 4 selected
        echo "CPU and Memory Alert            -       *SELECTED*"
        sed -i -e '/"cpu"/r cpu-inst.txt' installed-choices.sh
        sleep 1
    fi
    if [[ ${choices[4]} ]]; then
        #Option 5 selected
        echo "CSF LFD Firewall alerts         -       *SELECTED*"
        sed -i -e '/"csf"/r csf-inst.txt' installed-choices.sh
        sleep 1
    fi
    if [[ ${choices[5]} ]]; then
        #Option 6 selected
        echo "SSH Login alerts                -       *SELECTED*"
        sed -i -e '/"ssh"/r ssh-inst.txt' installed-choices.sh
        sleep 1
    fi
}

#Variables
ERROR=" "

#Clear screen for menu
clear

#Menu function
function MENU {
    echo "System Messages Install Options!
    (Pick one, all or any seletion of these notifications)"
    for NUM in ${!options[@]}; do
        echo "[""${choices[NUM]:- }""]" $(( NUM+1 ))") ${options[NUM]}"
    done
    echo "$ERROR"
}

#Menu loop
while MENU && read -e -p "Select the options you would like using their number (tap the number again to uncheck, Press ENTER when done!): 

" -n1 SELECTION && [[ -n "$SELECTION" ]]; do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

ACTIONS

chmod +x installed-choices.sh

./installed-choices.sh

