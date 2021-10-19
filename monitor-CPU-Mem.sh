#!/bin/bash
######################################################################
######## CPU and MEMORY WARNING SCRIPT ###############################
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

bell=$'U1F514'
toolbox=$'\U1F9F0'
policelight=$'\U1F6A8'
exclamation=$'\U2757'
disk=$'\U1F4BD'

#Temporary files to store data
resource_usage_info=/tmp/resource_usage_info.txt
msg_caption=/tmp/telegram_msg_caption.txt

#Set THRESHOLD levels for memory usage and load here. If the usage exceeds these values, the notification will be sent.
mem_threshold="YOUR_MEMORY_THRESHOLD" #Should be interger. This is in percentage
load_threshold=$(nproc) 

#Telegram API to send notificaiton.
function telegram_send
{
curl -s -F chat_id=$chat_id -F document=@$resource_usage_info -F caption="$caption" https://api.telegram.org/bot$token/sendDocument > /dev/null 2&>1
}

#Monitoring Load on the server
while :
do
    min_load=$(cat /proc/loadavg | cut -d . -f1)
    if [ $min_load -ge $load_threshold ]
        then
        echo -e "$exclamation High CPU usage detected on $(hostname)\n$(uptime)" > $msg_caption
        echo -e "CPU usage report from $(hostname)\nServer Time : $(date +"%d%b%Y %T")\n\n\$uptime\n$(uptime)\n\n%CPU %MEM USER\tCMD" >         $resource_usage_info
        ps -eo pcpu,pmem,user,cmd | sed '1d' | sort -nr >> $resource_usage_info
        caption=$(<$msg_caption)
        telegram_send
        rm -f $resource_usage_info
        rm -f $msg_caption
        sleep "YOUR_RESET_TIMING" #stop executing script for...
    fi
    sleep 10

#Monitoring Memory usage on the server
    mem=$(free -m)
    mem_usage=$(echo "$mem" | awk 'NR==2{printf "%i\n", ($3*100/$2)}')
    if [ $mem_usage -gt $mem_threshold ]
    then
        echo -e "$exclamation High Memory usage detected on $(hostname)\n$(echo $mem_usage% memory usage)" > $msg_caption
        echo -e "Memory consumption Report from $(hostname)\nServer Time : $(date +"%d%b%Y %T")\n\n\$free -m output\n$mem\n\n%MEM %CPU USER\tCMD" > $resource_usage_info
        ps -eo pmem,pcpu,user,cmd | sed '1d' | sort -nr >> $resource_usage_info
        caption=$(<$msg_caption)
        telegram_send
        rm -f $resource_usage_info
        rm -f $msg_caption
        sleep "YOUR_RESET_TIMING" #stop executing script for...
    fi
    sleep 20
done
