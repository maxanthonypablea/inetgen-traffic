#!/bin/bash
vpn_connect() {
sudo openvpn --mssfix --auth-nocache --config access.ovpn
}

redirect_only() {
while true :; 
    do cat ~/Documents/scripts/traffic/needle/data/user-agents.txt | while read agents;
         do cat ~/Documents/scripts/traffic/needle/data/urls.txt | while read urls;
            do cat ~/Documents/scripts/traffic/needle/data/redirector.txt | while read proxy;
                do curl -I -X GET -s $proxy -A $agents -L $urls; sleep 1; done; 
            done;
          done; 
    done;
}

proxified_connection () {
#http_proxy=$(curl -s 'http://pubproxy.com/api/proxy?speed=25&port=80' | jq '.data[].ipPort' | tr -d '"')
http_proxy=$(curl -s 'http://pubproxy.com/api/proxy?port=80' | jq '.data[].ipPort' | tr -d '"')
while true :;
    do cat ~/Documents/scripts/traffic/needle/data/user-agents.txt | while read agents;
        do cat ~/Documents/scripts/traffic/needle/data/urls.txt | while read urls;
            #do curl -I -X GET -A $agents -x $http_proxy -L $urls; sleep 1; done;
            do curl -I -X GET -A "$agents" -x 34.234.127.178:80 -L $urls; sleep 1; done;
        done;
    done;
}

#vpn_connect
proxified_connection
