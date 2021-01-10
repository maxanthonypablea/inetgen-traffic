#!/bin/bash

vpn_connect() {
    sudo openvpn --mssfix --auth-nocache --config access.ovpn
}

redirect_only() {
    while true :; 
        do cat ~/Documents/scripts/traffic/needle/data/user-agents.txt | while read agents;
            do cat ~/Documents/scripts/traffic/needle/data/urls.txt | while read urls;
                do cat ~/Documents/scripts/traffic/needle/data/redirector.txt | while read proxy;
                    do curl -I -X GET -s $proxy -A $agents -L $urls; done; 
                done;
            done; 
        done;
}

proxified_connection () {
    curl -s 'http://pubproxy.com/api/proxy?port=80&limit=100' | jq '.data[].ipPort' | tr -d '"' > proxies.txt
    #http_proxy=$(curl -s 'http://pubproxy.com/api/proxy?speed=25&port=80' | jq '.data[].ipPort' | tr -d '"')
    http_proxy=$(curl -s 'http://pubproxy.com/api/proxy?port=80' | jq '.data[].ipPort' | tr -d '"')

    while true :; do
        agents=$(shuf -n 1 ~/Documents/scripts/traffic/needle/data/user-agents.txt)
        proxies=$(shuf -n 1 ~/Documents/scripts/traffic/needle/data/proxies.txt)
        urls=$(shuf -n 1 ~/Documents/scripts/traffic/needle/data/urls.txt)
        #curl -I -X GET -A "$agents" -x "$proxies" -L "$urls";
        curl -I -X POST -A "$agents" -x "$proxies" -L "$urls";
    done;
}


webproxy_connection () {
    curl -s 'http://pubproxy.com/api/proxy?port=80&limit=100' | jq '.data[].ipPort' | tr -d '"' > proxies.txt
    #http_proxy=$(curl -s 'http://pubproxy.com/api/proxy?speed=25&port=80' | jq '.data[].ipPort' | tr -d '"')
    http_proxy=$(curl -s 'http://pubproxy.com/api/proxy?port=80' | jq '.data[].ipPort' | tr -d '"')

    while true :; do
        agents=$(shuf -n 1 ~/Documents/scripts/traffic/needle/data/user-agents.txt)
        urls=$(shuf -n 1 ~/Documents/scripts/traffic/needle/data/urls.txt)
        webproxy=$(shuf -n 1 ~/Documents/scripts/traffic/needle/data/webproxy.txt)
        #curl -I -X GET -A "$agents" "$webproxy" -L "$urls";
        curl -I -X POST -A "$agents" "$webproxy" -L "$urls";
    done;
}

#vpn_connect
#proxified_connection
webproxy_connection
cat /dev/null > proxies.txt
