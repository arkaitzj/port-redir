#!/bin/bash

function main() {

    set -x 

    if [ -n "${TARGET_IP}" ]; then
        DESTINATION="${TARGET_IP}"
    else
        DESTINATION=${POD_IP}
    fi

    for ports in $@; do
        echo "$ports"
        from=$(echo "$ports" | cut -d ':' -f 1)
        to=$(echo "$ports" | cut -d ':' -f 2)

        # For outside connections
        iptables -t nat -A PREROUTING -p tcp -i eth0 -d ${DESTINATION} --dport $from -j REDIRECT --to-port $to

        # For localhost connections, like istio sidecars
        iptables -t nat -A OUTPUT -p tcp -o lo -d ${DESTINATION} --dport $from -j REDIRECT --to-port $to
    done

    iptables -t nat --list


}

main "$@"
