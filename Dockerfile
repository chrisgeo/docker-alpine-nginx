FROM alpine:3.2
MAINTAINER Chris George "chris.a.george@gmail.com"

# install common packages
RUN apk add --update-cache \
	bash \
	curl \
	geoip \
	libssl1.0 \
	openssl \
	pcre \
	sudo \
	&& rm -rf /var/cache/apk/*

# add nginx user
RUN addgroup -S nginx && \
  adduser -S -G nginx -H -h /opt/nginx -s /sbin/nologin -D nginx

COPY bin
RUN build

RUN mkdir /opt/nginx/ssl
COPY nginx.conf /opt/nginx/nginx.conf
COPY mime.types /opt/nginx/mime.types
COPY default /opt/nginx/sites-enabled/default
COPY default-ssl /opt/nginx/sites-available/default-ssl

EXPOSE 80 443
CMD ["/opt/nginx/sbin/nginx", "-g", "daemon off;"]
