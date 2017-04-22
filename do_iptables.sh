#!/bin/bash

# generates the 'geoblock' list, loads the list.
sudo ./set_reload_list.sh

# block all the countrys in the list; drop/re-create
sudo iptables -D INPUT -m set --match-set geoblock src -j DROP
sudo iptables -I INPUT -m set --match-set geoblock src -j DROP

# use this for a positive list - block everything not listed in the list.
# sudo iptables -A INPUT -m set --set !geoblock src -j DROP
