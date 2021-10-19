#!/bin/bash
#----------------------------------------------------------------------------
# The base ssh notification script was from:
# https://gist.github.com/LM1LC3N7/b6f98611a1cd425cd5e328f90ed697f6
#----------------------------------------------------------------------------
# Edited to work with custom install paths, formatting and the install script
#----------------------------------------------------------------------------

#These are emoji codes used in the messages
bell=$'\U1F514'
exclamation=$'\U2757'
lock=$'\U1F510'
unlock=$'\U1F513'
# go to https://unicode.org/emoji/charts/full-emoji-list.html
# you will need its "U+1****" code MINUS the + As seen above

#----------------------------------------------------------------------------
# TELEGRAM CONFIG
#----------------------------------------------------------------------------
source "YOUR_INSTALL_DIR"/telegram.conf
echo "$token" > /dev/null 2&>1
echo "$chat_id" > /dev/null 2&>1

USERID="$chat_id"
# Create a new bot with @BotFather and start a new discussion with it
KEY="$token"
URL="https://api.telegram.org/bot${KEY}/sendMessage"

KNOWN_IPs="127.0.0.1"

#----------------------------------------------------------------------------
# SCRIPT CONFIG
#----------------------------------------------------------------------------

LOG_FILE="/var/log/telegram.log"
DATE="$(date "+%d %b %Y %H:%M:%S")"

touch ${LOG_FILE}
echo "" | tee -a ${LOG_FILE}
echo "Telegram alert script called at: $(date)" | tee -a ${LOG_FILE}
echo "User that runs the script: $(whoami)" | tee -a ${LOG_FILE}

#----------------------------------------------------------------------------
# Main
#----------------------------------------------------------------------------

if [[ ${KNOWN_IPs} == *"${PAM_RHOST}"* ]]; then
  echo "This IP is known, no Telegram alert (${PAM_RHOST})." | tee -a ${LOG_FILE}
  echo "DEBUG: ${KNOWN_IPs} == *${PAM_RHOST}." | tee -a ${LOG_FILE}
  exit 0
else
  echo "DEBUG: ${KNOWN_IPs} != *${PAM_RHOST}." | tee -a ${LOG_FILE}
fi

# Regex to determine if PAM_RHOST provide an IP or a FQDN
rx='([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])'
if [[ ${PAM_RHOST} =~ ^$rx\.$rx\.$rx\.$rx$ ]]; then
  USERIP=${PAM_RHOST}
  USERFQDN=""
else
  # Find the user IP (resolved by default by PAM as FQDN)
  USERIP="$(getent hosts ${PAM_RHOST} | cut -d' ')"
  USERFQDN=${PAM_RHOST}
fi

IPINFO="https://ipinfo.io/${PAM_RHOST}"
SRV_HOSTNAME=$(hostname -f)
SRV_IP="$(hostname -I | awk '{print $1}')"

echo "SRV_IP = $(ip addr show eth0 | grep inet | awk '{print $2}' | cut -d/ -f1)" | tee -a ${LOG_FILE}
echo "SRV_IP = ${SRV_IP}" | tee -a ${LOG_FILE}
echo | tee -a ${LOG_FILE}

# Generate the final text
TEXT="${bell} SSH Login Notification!

User: *${PAM_USER}* "

# Change string if it's a new connection or a disconnection
if [ "${PAM_TYPE}" = "open_session" ] ; then
  TEXT+="has connected ${lock} to: "
else
  TEXT+="has disconnected ${unlock} from "
fi

# Generate the final text
TEXT+="*${HOSTNAME}* (${SRV_IP}).
From IP: *${USERIP}* ${USERFQDN}
More information: [${IPINFO}](${IPINFO})
Date: ${DATE}
Service: ${PAM_SERVICE}
TTY: ${PAM_TTY}"

echo "${TEXT}" | tee -a ${LOG_FILE}

# Run in background so the script could return immediately without blocking PAM
curl -s --max-time 10 --retry 5 --retry-delay 2 --retry-max-time 10  -d "chat_id=${USERID}&text=${TEXT}&disable_web_page_preview=true&parse_mode=markdown" ${URL} | tee -a ${LOG_FILE} &

exit 0

