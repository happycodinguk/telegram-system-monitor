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
rm -rv /$inspath

#systemctl remove services
rm -rv /etc/systemd/system/storage-warn-tgm.service
rm -rv /etc/systemd/system/storage-warning.timer

rm -rv /etc/systemd/system/system-warn-tgm.service
rm -rv /etc/systemd/system/cpu-mem-alert.service

rm -rv /etc/systemd/system/postfix-report.service
rm -rv /etc/systemd/system/postfix-report.timer

rm -rv /etc/systemd/system/csf-lfd-alert.service


