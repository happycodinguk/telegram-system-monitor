#!/bin/bash
######################################################################
######## CSF LFD Notifications #######################################
######################################################################
# You will need to enable the relevant notifications in your CSF config file
# ie LF_SSH_EMAIL_ALERT etc. If these aren't enabled the log file won't have 
# log entries to send via telegram
######################################################################

source telegram.conf
echo "$token" > /dev/null 2&>1
echo "$chat_id" > /dev/null 2&>1

#Below are emoji codes ####################################### 
# go to https://unicode.org/emoji/charts/full-emoji-list.html
# you will need its "U+1F4EB" code MINUS the + As seen below
##############################################################
padlock=$'\U1F512'
lookingglass=$'\U1F50D'

#Telegram API to send notification.
function telegram_send
{
curl -s -X POST https://api.telegram.org/bot"$token"/sendMessage -d chat_id="$chat_id" -d text="$padlock CSF LFD alert $lookingglass 

$(hostname) 
$message"
}


tail -fn0 /var/log/lfd.log | 
while read -r line
do
   [[ "$line" != *"*"* ]] && continue
   echo $line > /tmp/lfd.txt 


message=$(</tmp/lfd.txt)
echo "$message" > /dev/null 2&>1

telegram_send > /dev/null 2&>1
rm -r /tmp/lfd.txt
done

