FROM alpine:3.1
MAINTAINER Jose Monreal <jmonreal@gmail.com>

RUN apk -U upgrade \
    && apk add make wget go git gcc musl-dev openssl-dev bash libgcc \
    && export GOPATH=/go \
    && go get -u -v github.com/hashicorp/consul-template \
    && cd /go/src/github.com/hashicorp/consul-template \
    && git checkout v0.9.0 \
    && make \
    && mv bin/consul-template /bin/ \
    && cd /tmp \
    && rm -rf /go \
    && apk del make wget go git gcc musl-dev openssl-dev bash libgcc \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /etc/consul-template.d

VOLUME ["/etc/consul-template.d"]

ENTRYPOINT ["/bin/consul-template"]

CMD []
