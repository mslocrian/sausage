FROM golang:1.11.5-alpine3.8
LABEL maintainer="Stegen Smith <stegen@owns.com>"

RUN apk update && apk add alpine-sdk autoconf automake bash python py-pip && \
    rm -rf /var/cache/apk/*

WORKDIR /go/src/github.com/mslocrian/dragnet

COPY . .
RUN make build-local

FROM alpine:3.9
WORKDIR /usr/local
COPY --from=0 /go/src/github.com/mslocrian/dragnet/dragnet .
COPY --from=0 /go/src/github.com/mslocrian/dragnet/dragnet.yml /etc/dragnet.yml
ENTRYPOINT ["/usr/local/dragnet"]
