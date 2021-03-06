#!/bin/bash

# This script will uninstall the scripts and services!  

read -e -p "
##################################################

Which path did you install the scripts in???

Enter For DEFAULT LOCATION: 

/usr/local/scripts/custom-monitor-tgm

##################################################

Filepath:" inspath
: ${inspath:=/usr/local/scripts/custom-monitor-tgm}
echo "You entered $inspath"

#####################################################################
# Dont Edit below here !!!!!!!!!
#####################################################################

systemctl stop storage-warn-tgm.service

systemctl disable storage-warn-tgm.service

systemctl stop storage-warning.timer

systemctl disable storage-warning.timer


systemctl stop postfix-report.service

systemctl disable postfix-report.service

systemctl stop postfix-report.timer

systemctl disable postfix-report.timer


systemctl stop system-warn-tgm.service

systemctl disable system-warn-tgm.service


systemctl stop cpu-mem-alert.service

systemctl disable cpu-mem-alert.service


systemctl stop csf-lfd-alert.service

systemctl disable csf-lfd-alert.service


systemctl daemon-reload

#Remove installed scripts
rm -frv $inspath
rm -fr /tmp/tg_install

#systemctl remove services
rm -frv /etc/systemd/system/storage-warn-tgm.service
rm -frv /etc/systemd/system/storage-warning.timer

rm -frv /etc/systemd/system/system-warn-tgm.service

rm -frv /etc/systemd/system/cpu-mem-alert.service

rm -frv /etc/systemd/system/postfix-report.service
rm -frv /etc/systemd/system/postfix-report.timer

rm -frv /etc/systemd/system/csf-lfd-alert.service

# Remove SSH Warning link in /etc/pam.d/sshd if it exists
sed -i '/ssh-login-warning.sh/d' /etc/pam.d/sshd

read -e -p "
Removed SSH Warning link in /etc/pam.d/sshd if it exists

UNINSTALL COMPLETE"

exit 0
