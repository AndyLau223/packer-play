#!/usr/bin/env bash
: ${HOST=localhost}
: ${PORT=8000}
: ${HTTP_OK=200}
function testUrl() {
    url=$@
    if $url -ks -f -o /dev/null
    then 
        return 0 
    else 
        return 1
    fi;
}

function waitForService() {
    url=$@
    echo -n "Wait for: $url..."
    n=0 
    until testUrl $url 
    do 
        n=$((n+1))
        if [[ $n == 100 ]]
        then 
            echo " Give up"
            exit 1
        else 
            sleep 3 
            echo -n ", retry #$n"
        fi 
    done 
    echo
    echo "Service is up and running!"
}

waitForService curl -k http://$HOST:$PORT