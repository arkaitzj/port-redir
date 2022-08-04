#!/bin/bash

function main() {

    set -x 

    for ports in $@; do
        echo "$ports"
        from=$(echo "$ports" | cut -d ':' -f 1)
        to=$(echo "$ports" | cut -d ':' -f 2)

        iptables -t nat -A PREROUTING -p tcp -i eth0 --dport $from -j REDIRECT --to-port $to
    done

    iptables -t nat --list


}

main "$@"
