FROM debian:oldstable

#Maintainer
LABEL description="Inception"
LABEL version="1.0"

#Install nginx and openssl
RUN apt update  -y && apt upgrade -y && apt install -y nginx openssl 

#Create the directory for the SSL certificate and key
RUN mkdir -p /etc/nginx/ssl
RUN  mkdir -p /var/www/website


#Generate SSL certificate and key
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out    /etc/ssl/certs/cert.crt \
    -keyout /etc/ssl/private/key.key \
    -subj "/C=CA/ST=QUEBEC/L=QUEBEC/0=42School/OU=hsaadi/CN=hsaadi"


#copie the nginx.config file to setup the server
COPY website /var/www/website
COPY conf/ngnix.conf /etc/nginx/conf.d/nginx.conf

# Use envsubst to replace environment variables in the Nginx configuration
RUN sed -i 's/\hsaadi.42.fr/"hsaadi.42.fr"/g' /etc/nginx/conf.d/nginx.conf

EXPOSE 80 443

#Start the nginx server
CMD [ "nginx", "-g", "daemon off;"]