# How to create private key?

Private key creation can be done on any machine.

```bash
openssl genpkey -algorithm RSA -out ${HOSTNAME}.key -pkeyout rsa_keygen_bits:4096
# old style
openssl genrsa -out $HOSTNAME 4096
```

## Where to find help?

-algorithm can be (RSA|DSA|DH|DHX), where do i find this information? man openssl-genpkey
The following text is copied from the manpage

```shell
-algorithm : Public key algorithm to use such as RSA, DSA, DH or DHX. If used this option must precede any -pkeyopt options
```

`-pkeyout` what should i fill in here, search KEY GENERATION OPTIONS in the man page.

```shell
rsa_keygen_bits:numbits
    The number of bits in the generated key. If not specified 2048 is used.
```

> [Warning] In above example private key is not protected.

## How to create csr (request) ?

while creating csr you should remember that it is new and it is request

```shell
openssl req -new -key ${HOSTNAME}.key -out ${HOSTNAME}.csr
```
It is also good idea to check csr, important thing here to remember is, again it is req. `noout` basically means, do not output certificate request

`openssl req -in ${HOSTNAME}.csr -noout -text`

## How to request (self) sign a certificate

This is bit simple, but again it is request and you use your own private key to sign your own certificate

`openssl req -x509 -in ${HOSTNAME}.csr -out ${HOSTNAME}.crt -key ${HOSTNAME}.key`

## How to create a CSR (request) with SAN?

```shell
openssl req -new -key rhelserv.key -out rhelserv.csr -subj "/CN=developments.apps-crc.testing/C=DE/ST=Baden Wuerttermberg/L=Stuttgart/O=Divine Purpose/OU=ICT/emailAddress=nodiesop@gmail.com" -addext "subjectAltName = DNS:developments.apps-crc.testing,DNS:192.168.50.126"
```

I was wondering where to find the information to fill esp the shortcuts for -subj field. It is in openssl-req man page. Below is the text from it.

```shell
[ req_distinguished_name ]
C                      = GB
ST                     = Test State or Province
L                      = Test Locality
O                      = Organization Name
OU                     = Organizational Unit Name
CN                     = Common Name
emailAddress           = test@email.address
```

And while searching, i also found out that -addext example in the man page. Again pasted below for future reference because I felt i kept missing important attribute which `DNS:`

```shell
openssl req -new -subj "/C=GB/CN=foo" \
-addext "subjectAltName = DNS:foo.co.uk" \
-addext "certificatePolicies = 1.2.3.4" \
-newkey rsa:2048 -keyout key.pem -out req.pem
```

## Finally, request a signed certificate

Remember it is request but a request for x509 and not a -new request.

```shell

openssl req -x509 -key rhelserv.key -out rhelserv.crt -in rhelserv.csr -addext "subjectAltName = DNS:developments.apps-crc.testing,DNS:192.168.50.126"

```