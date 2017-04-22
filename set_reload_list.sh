#!/bin/bash
# this command destroy, create and refreshes the list 
#  useful for a crontab, eg. once a week ?
#  or at reboot ?

# create the list
sudo ipset create geoblock hash:net,port

# load the list
./set_iplist.sh


