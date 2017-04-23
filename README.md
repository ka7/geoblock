# geoblock

using this scripts, you can block traffic by region via iptables.
e.g. you want to stop the ssh-attacks from china ?

how it works:
- in conf/ there are files 'country_block.xx.conf'
-- the 'xx' is the port-number ( eg. 22 for ssh, 80 for web, .. )
- in the file, there is the 2-digit country-code.. CN=china, US=usa, ...
- so you can block on each port different countries.
-- this is on iptables level with DROP.
-- it will also kick-out search-engines (maybe you want ?)
- real hackers will not work "from home" but from some other IPs

example:
- you/your server is in france.
- you see many attacks from UA, CN, JP, KR on ssh. 
- there will be no real connects from these countries ( vacation, anyone ?)
-- block them.

there are other ways, like 
- fail2ban.
find a list of similar stuff here: http://alternativeto.net/software/fail2ban/

real example:
- on startup, call 'do_iptables.sh'
-- it will load the list, set the ip-table rule.
-- add to the rc.local ?
- if you want to refresh the list, run 'set_relaod_list.sh'
-- this refreshes the list via web. IP-lists via ipdeny.com
-- you want to do this maybe once a week (and is done at startup)


project inspired by
http://www.dghost.com/techno/internet/banning-an-entire-country-with-iptablesipset
