This script will install Telegram Messenger API Notifications for server monitoring.

Current alerts:

- Postfix Activity Reports (Dependency for Posfix reports: pflogsumm - https://packages.debian.org/sid/pflogsumm)
- Low Storage Alerts 
- System Service Failure Alerts 
- CPU and Memory Alerts 
- CSF LFD Firewall Alerts

INSTALL SCRIPT TESTED ON: 
DEBIAN 10 
CENTOS 7 

- Will test others soon.

This project is for all to enjoy. Hoping some people will contribute more notification options, tweak etc!
If you have a testing platform and 5 minutes (thats how long it takes to install from the script 
and get notifications), be good to get more opinions on it!

DM on:
Telegram: https://t.me/joinchat/xlmtm7jVYR4yODQ0

Keep your eye on files for updates as new features and improvements are inbound.

Recently added:
*Timed Postfix Activity Reports Added!
*System monitor improved
*CSF LFD Firewall alerts added (currently it sends all "*" notifications - 
on boot you'll get quite a few of system start up notes. Will filter this later)

Will do fail2Ban for those who use that next!

Looking to integrate (contributions appreciated!):
SSH Login notifications (If you have CSF firewall, theses are included in CSF integration)
CPU temperature

Discussion points:
The 1 shot scripts are running on systemd timers. General consensus, there are more benefits than cron.
More info on SYSTEMD timers: https://opensource.com/article/20/7/systemd-timers

The loop scripts check frequently (editable) the services required for monitoring and have the ability to 
mute new alerts for X amount of time should an alert occur... While you go login and check the system's processes.

Please be aware this script is compiled with my knowledge and snippets found across forums/web pages.
Should have made a note of them really. Thanks for the snippets guys. 
If you would like a credit on this GIT, drop me a message and I'll add ya!
Better still join in and lets get some more notifications added... Or clone it and improve! 
Progress is always good.

###############################################################################################
AUTOMATIC INSTALL PROCESS
###############################################################################################
1st. Take a look over the files, always a good process for any third party installs!
There's four very small scripts and services which will send messages for different reports.

These files will be installed if you choose them during install options:

https://github.com/happycodinguk/telegram-system-monitor/blob/main/postfix-report.sh
https://github.com/happycodinguk/telegram-system-monitor/blob/main/storage-warning.sh
https://github.com/happycodinguk/telegram-system-monitor/blob/main/system-warnings.sh
https://github.com/happycodinguk/telegram-system-monitor/blob/main/monitor-CPU-Mem.sh
https://github.com/happycodinguk/telegram-system-monitor/blob/main/csf-lfd-notifications.sh

Then there are the systemd .service and .timer files to run these.
Your single telegram config file which is for all scripts. You edit this to change to new bot!

The template and .txt files are only for the options during the install process.

For those not too familiar with GIT. You don’t need to copy all the files on here. It's not as 
complicated as it looks....

The single install.sh script will pull the files it needs during the install process!
############################################################################################### 
# To install:
# In terminal:
# 	wget https://raw.githubusercontent.com/happycodinguk/telegram-system-monitor/main/install.sh
# 	chmod +x install.sh
# 	./install.sh 
###############################################################################################
# If you have any issues you can manually create the file:
# In a terminal window:
#
# 	nano install.sh
#
# In any web browser: https://raw.githubusercontent.com/happycodinguk/telegram-system-monitor/main/install.sh
# Copy, then paste the text from page into nano editor!
# Save.
# 	chmod +x install.sh
# 	./install.sh 
####################################################################

****************************************************************
WELCOME!
################################################################
You can view all installation files at: 
https://github.com/happycodinguk/telegram-system-monitor 
Please leave feedback or message on telegram https://t.me/joinchat/xlmtm7jVYR4yODQ0

This script will install Telegram Messenger API Notifications: 

- Postfix Activity Reports
- Low Storage Alerts 
- System Service Failure Alerts 
- CPU and Memory Alerts
- CSF LFD Firewall Alerts

During install you will need to input: 

- Which notifications you would like to setup.
- Which location you would like to install the scripts.
- Your telegram bot credentials.
- What percentage you would like to receive HD Storage alarm. 
- Various reset times.
- Which partition you would like to monitor.
- Which SYSTEMD services you would like monitor.

TIP 1:
---------------------------------------------------------------
To find running services you would like to monitor, open a 
second terminal window now and enter:

    systemctl list-units --type=service
    
You will need the SYSTEMD Service name MINUS .service! Don't fear, 
you will be presented with a list of basics for a standard 
Virtualmin server. You can copy and edit that list into the 
install process. 

TIP 2:
---------------------------------------------------------------
You will also need the location of the partition you will like 
to monitor. To find your /dev/ storage (mine is /dev/sda):

In terminal type:

    lsblk -l

TIP 3:
---------------------------------------------------------------
Set your alert levels LOW to test the alerts work, run the 
UN-INSTALL - Then RE-INSTALL with sensible values. The uninstall 
file location will be shown at the end of installation.


YOU CAN DISABLE ANY OF THESE SERVICES (IF NOT REQUIRED) BY RUNNING 

#############################################################
Summary
#############################################################
To completely un-install this setup please run:

    bash /YOUR_CHOSEN_INSTALL_PATH/uninstall.sh

You must run the un-install BEFORE running the install process again!
That's the easy way to change your options.

To manually edit key files go to:

    /YOUR_CHOSEN_INSTALL_PATH/storage-warning.sh
    /etc/systemd/services/storage-warning.timer
    
    /YOUR_CHOSEN_INSTALL_PATH/postfix-report.sh
    /etc/systemd/services/postfix-report.timer
    
    /YOUR_CHOSEN_INSTALL_PATH/system-warning.sh
    
    /YOUR_CHOSEN_INSTALL_PATH/monitor-CPU-Mem.sh 
    
    /YOUR_CHOSEN_INSTALL_PATH/csf-lfd-notifications.sh

DEFAULT location: /usr/local/scripts/custom-monitor-tgm

You can manually edit your emoji codes inside these files to 
customise your message looks....

To test CPU warning you will need to install stress (apt-get install stress).

Then run:

	stress --cpu 4

The "4" relates to the amount of cores in your processor, adjust accordingly.

More info at https://www.tecmint.com/linux-cpu-load-stress-test-with-stress-ng-tool/

Enjoy!
