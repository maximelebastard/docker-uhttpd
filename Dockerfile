
# STEP 1 : Build

FROM golang:alpine as builder

RUN apk update && apk add git

RUN go get github.com/nesv/uhttpd

# STEP 2 : Make a tiny image from alpine

FROM alpine:latest

#RUN opkg-install uhttpd
#RUN printf '#!/bin/sh\nset -e\n\nchmod 755 /www\nexec /usr/sbin/uhttpd $*\n' > /usr/sbin/run_uhttpd && chmod 755 /usr/sbin/run_uhttpd

COPY --from=builder /go/bin/uhttpd /usr/local/bin/uhttpd

VOLUME ["/www"]

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/uhttpd", "-f", "-p", "80", "-h", "/www"]
CMD [""]
