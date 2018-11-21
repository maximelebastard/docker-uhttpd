FROM        alpine:latest
MAINTAINER  Maxime Lebastard <maxime@pathmotion.chmod>


#RUN opkg-install uhttpd
#RUN printf '#!/bin/sh\nset -e\n\nchmod 755 /www\nexec /usr/sbin/uhttpd $*\n' > /usr/sbin/run_uhttpd && chmod 755 /usr/sbin/run_uhttpd

COPY $GOPATH/bin/uhttpd /usr/local/bin/uhttpd

VOLUME ["/www"]

EXPOSE 80

ENTRYPOINT ["uhttpd", "-f", "-p", "80", "-h", "/www"]
CMD [""]
