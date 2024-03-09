ARG	DOMAIN_NAME
FROM    alpine:3.19.1

LABEL   description="Inception"
LABEL   version="1.0"

RUN     apk update && \
    	apk add --no-cache nginx openssl ca-certificates && \
	mkdir -p /run/nginx   

#copy all necessary files
COPY    tools/generate_ssl.sh /tools/
COPY    conf/nginx.conf /etc/nginx/
COPY    site /usr/share/nginx/site

#Give permissions and Run SCRIPT
RUN     chmod +x tools/generate_ssl.sh
RUN     tools/generate_ssl.sh DOMAIN=${DOMAIN_NAME}

#Expose 80 for http and 443 for https
EXPOSE  80
EXPOSE  443

#Launch launch
CMD     ["nginx", "-g", "daemon off;"]

