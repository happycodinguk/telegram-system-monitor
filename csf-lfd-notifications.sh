#!/bin/bash
######################################################################
######## CSF LFD Notifications #######################################
######################################################################
# Hope people enjoy the many hours I have put into this project!
# This project is created with my knowledge and some snippets from 
# across the open web. If there are snippets you would like credit for. 
# Drop me a line and I'll add you!
# Anyone. Feel free to clone and improve.
####################################################
# DM me on:                                        #
# Telegram: https://t.me/joinchat/xlmtm7jVYR4yODQ0 #
####################################################


source telegram.conf
echo "$token" > /dev/null 2&>1
echo "$chat_id" > /dev/null 2&>1

#These are emoji codes 
# go to https://unicode.org/emoji/charts/full-emoji-list.html
# you will need its "U+1F4EB" code MINUS the + As seen below
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
echo "$message"

telegram_send

rm -r /tmp/lfd.txt
sleep 5
done



