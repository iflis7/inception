FROM debian:oldstable

RUN apt update  -y && apt upgrade -y
RUN apt install -y nginx openssl 

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out    /etc/ssl/certs/cert.crt \
    -keyout /etc/ssl/private/key.key \
    -subj "/C=CA/ST=Quebec/L=Quebec/O=42/OU=inception/CN=hsaadi.42.fr"

COPY conf/ngnix.conf /etc/nginx/conf.d/nginx.conf

# Use envsubst to replace environment variables in the Nginx configuration
RUN sed -i 's/\hsaadi.42.fr/"hsaadi.42.fr"/g' /etc/nginx/conf.d/nginx.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;"]