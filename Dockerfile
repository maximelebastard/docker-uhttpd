
# STEP 1 : Build

FROM golang:alpine as builder

RUN apk update && apk add git

RUN go get github.com/nesv/uhttpd

# STEP 2 : Make a tiny image from alpine

FROM alpine:latest

COPY --from=builder /go/bin/uhttpd /usr/local/bin/uhttpd
RUN printf '#!/bin/sh\nset -e\n\nexec /usr/local/bin/uhttpd $*\n' > /usr/local/bin/run_uhttpd && chmod 755 /usr/local/bin/run_uhttpd


VOLUME ["/www"]

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/run_uhttpd", "-addr", ":80", "-dir", "/www", "-log"]