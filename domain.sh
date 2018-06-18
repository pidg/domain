#!/bin/bash

# domain.sh
# Looks for unregistered domain names across multiple registries
#
# by @tarasyoung
# Licence: Apache 2.0
#
# Usage:
# ./domain.sh domain1 domain2 domain3
#

clear; echo Checking domains

echo "Available domains:"

i=0;
for var in "$@"
do
    tput sc; tput cup 0 0; echo '                      '
    tput cup 0 0; echo Checking $var
    tput rc

    whois $var.org.uk | grep -q "No match" && echo "$var.org.uk"                # .org.uk
    whois $var.co.uk | grep -q "No match" && echo "$var.co.uk"                  # .co.uk
    whois $var.com 2>/dev/null | grep -q "No match for" && echo "$var.com"      # .com
    whois $var.net 2>/dev/null | grep -q "No match for" && echo "$var.net"      # .net
    whois $var.org | grep -q "NOT FOUND" && echo "$var.org"                     # .org

# You can check more domains by adding them in this format.
# Registry information must be made available to whois by adding the servers to  /etc/whois.conf
#
#    whois $var.link | grep -q "is available for registration" && echo "$var.link"      # .link
#    whois $var.click | grep -q "is available for registration" && echo "$var.click"    # .click

    let i++;

    if [ $i == 2 ]; then
      tput sc; tput cup 0 25; echo 'Waiting politely...'
      sleep 1;
      tput cup 0 25; echo '                   '
      tput rc
      i=0;
    fi

done
