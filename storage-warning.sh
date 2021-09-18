#!/bin/bash
######################################################################
######## STORAGE SPACE WARNING SCRIPT ################################
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


source telegram.conf
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

function telegram_send
{
curl -s -X POST https://api.telegram.org/bot"$token"/sendMessage -d chat_id="$chat_id" -d text="$policelight Your "YOUR_HD_LOCATION" partition available space is critically low on $(hostname) $(date) $exclamation

Used: $CURRENT% $disk"
}

CURRENT=$(df | grep '"YOUR_HD_LOCATION"' | awk '{print $5}' | sed 's/%//g')
THRESHOLD="YOUR_HD_THRESHOLD"
        if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
        echo "$MESSAGE" | telegram_send
        fi
        
# >>>>>    To edit timing for this process:    nano /etc/systemd/system/storage-warning.timer     <<<<<<<<<
