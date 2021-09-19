#!/bin/bash
######################################################################
######## SYSTEMD Service RESTART and WARNING SCRIPT ##################
######################################################################
# Hope people enjoy the many hours I have put into this project!
# This project is created with my knowledge and some snippets from 
# across the open web. If there are snippets you would like credit for. 
# Drop me a line and I'll add you!
# Anyone. Feel free to clone and improve.
####################################################
# DM me on:                                        #
# Telegram: https://t.me/joinchat/xlmtm7jVYR4yODQ0 #
# Discord: https://discord.gg/uf2h4TdbQ7           #
####################################################

source "YOUR_INSTALL_DIR"/telegram.conf
echo "$token"
echo "$chat_id"

#These are emoji codes 
# go to https://unicode.org/emoji/charts/full-emoji-list.html
# you will need its "U+1F4EB" code MINUS the + As seen below

bell=$'U1F514'
toolbox=$'\U1F9F0'
policelight=$'\U1F6A8'
exclamation=$'\U2757'
disk=$'\U1F4BD'

##list your SYSTEM services you want to check on!
SERVICES=( "SERVICES_TO_MONITOR" )

#Telegram API to send notificaiton.
 
function telegram_send
{
curl -s -X POST https://api.telegram.org/bot"$token"/sendMessage -d chat_id="$chat_id" -d text="$policelight 
$SUBJECT 
$toolbox $MESSAGE"
}

while true :
do
        for i in "${SERVICES[@]}"
        do
          if [[  "$(systemctl show -p ActiveState "$i")" =~ "inactive"  ]]
                then
                sleep 5
                service "$i" start
                MESSAGE="$(tail -5 /var/log/"$i"/error.log)"
                SUBJECT="$i is inactive on $(hostname) $(date) - Please investigate!"
                echo "$MESSAGE" | telegram_send
                sleep "YOUR_RESET_TIMING" #stop executing script for?
                 fi
          if [[  "$(systemctl show -p ActiveState "$i")" =~ "failed"  ]]
                then
                sleep 5
                service "$i" start
                MESSAGE="$(tail -5 /var/log/"$i"/error.log)"
                SUBJECT="$i is failed on $(hostname) $(date) - Please investigate!"
                echo "$MESSAGE" | telegram_send
                sleep "YOUR_RESET_TIMING" #stop executing script for?
                 fi
                done
        sleep 20
        done
