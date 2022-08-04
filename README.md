# arkaitzj/port-redir

Iptables based container intended to be run as initContainer to redirect one port to another

If you have a container listening in the wrong port, this can help you.

It is also useful in environments where communication across kubernetes nodes is restricted via external firewalling.


## Kubernetes Manifest

Use it as an initContainer and redirect as many ports as needed

```
# Software is listening at port 4443 but our network only allows 9443
      initContainers:
      - name: init-networking
        image: arkaitzj/port-redir
        args:
          - 9443:4443
        securityContext:
          capabilities:
            add:
            - NET_ADMIN
          privileged: true
      containers:
      - name: othercontainer
        image: image_prepared_to_listen_at_4443
        ports:
          - containerPort: 9443
```
