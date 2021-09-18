#!/bin/bash
######################################################################
######## POSTFIX REPORT SCRIPT #######################################
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

postfix_info=/tmp/mailer.txt

#These are emoji codes 
# go to https://unicode.org/emoji/charts/full-emoji-list.html
# you will need its "U+1F4EB" code MINUS the + As seen below

chart=$'\U1F4CA'
email=$'\U1F4E8'

bash /usr/sbin/pflogsumm -d today /var/log/mail.log > /tmp/mailer.txt
#Telegram API to send notification.
function telegram_send
{
curl -s -F chat_id=$chat_id -F document=@$postfix_info -F caption="$chart POSTFIX $email
Report as requested for: 
$(hostname)" https://api.telegram.org/bot$token/sendDocument > /dev/null 2&>1
}

        telegram_send
        rm -f $postfix_info


