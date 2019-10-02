#!/bin/bash

source "$(dirname "$0")/config.sh"

check_port () {
    port=$1
    curl -f -m $timeout "localhost:$port"
    if [ $? -ne 0 ]
    then
        echo "Failed: $port"
        eval "${services[$port]}"
        if [ $? -ne 0 ]
        then
            echo "Warning: Possible error when issuing restart command '${services[$port]}'"
        fi
    fi
}

for port in "${!services[@]}" 
do
    check_port $port
done
