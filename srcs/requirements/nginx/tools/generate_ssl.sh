#!/bin/sh
echo "Arguments received: $@" 

if [ "$#" -ne 1 ];
then
  echo "Usage: Must supply a domain"
  exit 1
fi

SSLPATH=/etc/ssl
KEYPATH=/etc/ssl/private
CERTPATH=/etc/ssl/certs
#mkdir -p "$KEYPATH" "$CERTPATH"

DOMAIN=$1

openssl req  -x509 -newkey rsa:2048 -nodes -keyout $KEYPATH/myCA.key -sha256 -days 365 -out $SSLPATH/myCA.pem -subj "/C=CA/ST=QUEBEC/L=QUEBEC/O=42QUEBEC/OU=hsaadi/CN=hsaadi.42.fr" 

cp $SSLPATH/myCA.pem /usr/share/ca-certificates/myCA.crt

# Update the certificates
apk update update-ca-certificates

openssl genrsa -out $KEYPATH/$DOMAIN.key 2049
openssl req -new -key $KEYPATH/$DOMAIN.key -out $CERTPATH/$DOMAIN.csr -subj "/C=CA"
#openssl req -newkey rsa:2048 -nodes -keyout $KEYPATH/$DOMAIN.key -out $CERTPATH/$DOMAIN.csr

#chmod +w 

cat > $CERTPATH/$DOMAIN.ext << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $DOMAIN
EOF

openssl x509 -req -in $CERTPATH/$DOMAIN.csr -CA $SSLPATH/myCA.pem -CAkey $KEYPATH/myCA.key -CAcreateserial \
-out $CERTPATH/$DOMAIN.crt -days 365 -sha256 -extfile $CERTPATH/$DOMAIN.ext

