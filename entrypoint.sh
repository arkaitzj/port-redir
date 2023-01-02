#!/bin/bash

IT="iptables"
function main() {

    set -x 
    LOCAL_IP="$(ip -4 addr show eth0 |  grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}')"

    if [ -n "${TARGET_IP}" ]; then
        DESTINATION="${TARGET_IP}"
    else
        DESTINATION="${LOCAL_IP}"
    fi

    for ports in "$@"; do
        IFS=":" read -ra tokens <<<"$ports"
        class="standard"
        if [ "${#tokens[@]}" -eq 3 ]; then
            class="${tokens[0]}"
            tokens=("${tokens[@]:1}")
        fi

        from=${tokens[0]}
        to=${tokens[1]}

        case "$class" in 
            standard)
                # For outside connections
                ${IT} -t nat -A PREROUTING -p tcp -i eth0 -d ${DESTINATION} --dport $from -j REDIRECT --to-port $to
                ;;
            istio)
                ${IT} -t nat -A OUTPUT -p tcp -o lo -s 127.0.0.6 -d ${DESTINATION} --dport $from -j REDIRECT --to-port $to
                ;;
            *)
                echo "Unknown class: ${class} from ${ports}"
        esac
    done

    ${IT} -t nat --list

}

main "$@"
