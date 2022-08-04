FROM alpine:3.15 as port-redir

RUN apk add iptables

WORKDIR /root

COPY entrypoint.sh .

ENTRYPOINT [ "./entrypoint.sh" ]
