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
  adduser -S -G nginx -H -h /etc/nginx -s /sbin/nologin -D nginx

COPY bin bin
RUN build

RUN mkdir /etc/nginx/ssl
COPY nginx.conf /etc/nginx/nginx.conf
COPY mime.types /etc/nginx/mime.types
COPY default /etc/nginx/sites-enabled/default
COPY default-ssl /etc/nginx/sites-available/default-ssl

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
