INSTALL SCRIPT TESTED ON: 
DEBIAN 10 
CENTOS 7 

This script will install Telegram BOT Notifications.
Pick one, all, or any combo if these notifications!

-------------------------------
- Postfix Activity Reports
- Low Storage Alerts 
- System Service Failure Alerts 
- CPU and Memory Alerts
- CSF LFD Firewall alerts
- SSH Login alerts (NOT WORKING ON CENTOS YET)
  If you have CSF firewall installed this option isnt needed as CSF/LFD gives SSH login alerts and much more!
-------------------------------

- You will need to run this script with root privileges using "sudo su" or logging in as root.
- You will choose an install location for the scripts (default options available).
- SSH Login alerts will install the script into your chosen location. 
  It will also add a link to trigger the script on SSH login in: 

  /etc/pam.d/sshd    (at the end of the file)
  
- SSH Login alerts option isn't needed if you are running CSF Firewall.
  CSF/LFD sends SSH, webmin login notifications along with IP blocking info etc.

>> Always have a backup of your system or try out in a testing environment<<

This project is for all to enjoy. Hoping some people will contribute more notification options, tweak etc!
If you have a testing platform and 5 minutes (thats how long it takes to install from the script 
and get notifications), be good to get more opinions on it!

DM on:
Telegram: https://t.me/joinchat/xlmtm7jVYR4yODQ0
Or discuss here! https://github.com/happycodinguk/telegram-system-monitor/discussions/1

Looking to integrate.
2FA
CPU temperature

Please be aware this script is compiled with my knowledge and snippets found across forums/web pages.
Should have made a note of them really. Thanks for the snippets guys. 
If you would like a credit on this GIT, drop me a message and I'll add ya!
Better still join in and lets get some more notifications added... Or clone it and improve! 
Progress is always good.

###############################################################################################
AUTOMATIC INSTALL PROCESS
###############################################################################################
1st. Take a look over the files, always a good process for any third party installs!
There's five very small scripts.
Then there are the systemd .service and .timer files to run these.
Your single telegram config file which is for all scripts. You edit this to change to new bot!

The template and .txt files are only for the options during the install process.

For those not too familiar with GIT. You don’t need to copy all the files on here. It's not as 
complicated as it looks....

The single install.sh script will pull the files it needs during the install process!

----------------------------------------------------------------------------------------------------
# To install:
# In terminal:
# 	wget https://raw.githubusercontent.com/happycodinguk/telegram-system-monitor/main/install.sh
# 	chmod +x install.sh
# 	./install.sh 
----------------------------------------------------------------------------------------------------
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
----------------------------------------------------------------------------------------------------

