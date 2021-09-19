#!/bin/bash

# This installer was written by https://github.com/happycodinguk
# Scripts compliled and edited for your server and telegram pleasure. 
# Am looking forward to its modification and improvement from the Open Source Community!
# Please leave feedback or message me on telegram https://t.me/joinchat/xlmtm7jVYR4yODQ0

read -p "
****************************************************************
WELCOME!
################################################################

Lets input your Telegram API info and installation path!
Enter your TELEGRAM BOT API Token:" telegram_api
: ${telegram_api:=THE USER DID NOT ENTER A VALUE}
echo "
Thank You!
I've entered: $telegram_api"


read -e -p "
##############################################################
Enter your TELEGRAM BOT Chat or channel ID:" chat_or_channel_id
: ${chat_or_channel_id:=THE USER DID NOT ENTER A VALUE}
echo "
Thank You!
I've entered: $chat_or_channel_id"

read -e -p "
###############################################################
Enter YOUR CHOSEN installation path!
Or just hit ENTER for the DEFAULT PATH:
    /usr/local/scripts/custom-monitor-tgm
**************************************************************
Filepath:" inspath
: ${inspath:=/usr/local/scripts/custom-monitor-tgm}
echo "
Thank You!
We will install here: $inspath"

mkdir -p $inspath
chmod 700 $inspath

sed -i 's|"YOUR_API_TOKEN_HERE"|'"$telegram_api"'|g' telegram.conf 

sed -i 's|"YOUR_CHAT_OR_CHANNEL_ID_HERE"|'"$chat_or_channel_id"'|g' telegram.conf 

mv -i telegram.conf $inspath
chmod 700 $inspath/telegram.conf

chmod +x uninstall.sh 

mv -i uninstall.sh $inspath/uninstall.sh

# "postfix"


# "storage"


# "system"


# "cpu"


# "csf"

read -p "
#############################################################
Summary
#############################################################

To completely un-install this setup please run:

     bash $inspath/uninstall.sh
    
>>>> You must run the un-install BEFORE running the install process again! <<<<

That's the easy way to change your options

To manually edit the scripts you chose on install go to:

    $inspath/storage-warning.sh
    /etc/systemd/system/storage-warning.timer
    
    $inspath/postfix-report.sh
    /etc/systemd/system/postfix-report.timer
    
    $inspath/system-warning.sh
    
    $inspath/monitor-CPU-Mem.sh 

No editing required on CSF LFD Alerts file.

You can manually edit your emoji codes inside these files to customise your message looks....
To test CPU warning you will need to install stress (apt-get install stress).

Then run: 
    stress --cpu 4
    
The "4" relates to the amount of cores in your processor, adjust accordingly.
More info at https://www.tecmint.com/linux-cpu-load-stress-test-with-stress-ng-tool/

ENJOY!
#############################################################
# Summary notes above - Please read ^^^^^^^^^^^^^^^^^^^^^^^^#                        
#############################################################
Remove temporary files?
Yes or No?" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

# Delete install files

rm -r /tmp/tg_install
