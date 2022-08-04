FROM alpine:3.15 as port-redir

RUN apk add iptables bash

WORKDIR /root

COPY entrypoint.sh .

ENTRYPOINT [ "./entrypoint.sh" ]
