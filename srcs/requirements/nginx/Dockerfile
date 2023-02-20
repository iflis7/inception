FROM alpine:3.13.5

RUN apk update && apk upgrade && apk add --no-cache nginx openssl

#nginx SSL
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/raccoman.pem \
    -keyout /etc/nginx/ssl/raccoman.key \
    -subj "/C=CA/ST=QUEBEC/L=QUEBEC/0=42 School/OU=hsaadi/CN=hsaadi"

# nginx config
RUN mkdir -p /run/nginx
COPY conf/nginx.conf /etc/nginx/sites-enabled/nginx.conf

EXPOSE 443
# start nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]

# The openssl req command is used to generate a self-signed certificate 
# and private key for use with the Nginx web server, and 
# the -newkey rsa:2048 option specifies that the key should use the RSA algorithm with a key length of 2048 bits. 
# The resulting certificate and private key can be used for 
# TLS encryption with support for TLSv1.3 if the Nginx configuration is also set up to enable TLSv1.3.

