FROM    alpine:3.19.1

ARG	DOMAIN

LABEL   description="Inception"
LABEL   version="1.0"

RUN     apk update && \
    	apk add --no-cache nginx openssl ca-certificates && \
	mkdir -p /run/nginx /etc/ssl/private /etc/ssl/certs  

#copy all necessary files
COPY    tools/generate_ssl.sh /tools/
COPY    conf/nginx.conf /etc/nginx/
COPY    site /usr/share/nginx/site

ENV DOMAIN=${DOMAIN}

#Give permissions and Run SCRIPT
RUN	chmod +w /etc/ssl/private /etc/ssl/certs 
RUN     chmod +x tools/generate_ssl.sh && \
	tools/generate_ssl.sh $DOMAIN

#Expose 80 for http and 443 for https
EXPOSE  80 443

#Launch launch
CMD     ["nginx", "-g", "daemon off;"]

