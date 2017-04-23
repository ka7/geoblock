#!/bin/bash

# load IPSET "geoblock" with data for $country
# logic is contry_block_$PORT.conf ( $PORT like 22, 80, 443, 25 )
# generate multiple files, like country_block.22.conf, country_block.80.conf ...


CONFDIR=$(dirname "$0")/conf; # but might be /etc/...

umask 066

sudo ipset flush geoblock

# get the list of 
wget -O /tmp/MD5SUM http://www.ipdeny.com/ipblocks/data/aggregated/MD5SUM 

logger '(re)loading geoblock list.'
# get the list of config-files, contains countries, one file per port ( like ssh, web, mail )
for PORT in $(find "$CONFDIR" -name "country_block.*.conf" | cut -c2-100 | awk -F . '{print $2}')
  do
  # read this special list, get country.
  grep -v "^#" "$CONFDIR/country_block.${PORT}.conf" | tr '[:upper:]' '[:lower:]' | while read country;
    do
    logger "...adding $country, block $PORT";
    ZONE="${country}-aggregated.zone"
 
    # load the file containing ip-lists
    wget -O "/tmp/$ZONE" "http://www.ipdeny.com/ipblocks/data/aggregated/$ZONE" 
    MD5=$(cd /tmp; md5sum "$ZONE")
    MD5HIT=$(grep -c "$MD5" /tmp/MD5SUM)
    if [ "$MD5HIT" -eq 1 ];
    then
      logger 'checksums do match; OK'
    else
      logger 'checksums do NOT match - ignore this file'
      exit
    fi       
    LINES=$(wc -l "/tmp/$ZONE")
    logger "...($LINES) loaded."
    cat "/tmp/$ZONE" | while read IP 
    do
      # regular ban - block port $PORT for IPs of countryXX
      sudo ipset add geoblock "$IP,$PORT" #&3> /dev/null 
    done 
  done
done

rm /tmp/MD5SUM



