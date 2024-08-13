
## SSL Certificates

The files you find here should no longer be trusted and are only a proof-of-concept and for your convenience. The command below generates a new RSA private key and a self-signed X.509 certificate, both valid for 365 days. The private key is saved to `nginx.key`, and the certificate is saved to `nginx.crt`. The private key is not encrypted with a passphrase. Your organization likely has a very particular way to acquire certificates, so this should only be used as a proof-of-concept certificate.

Example Command
```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt
```

* `openssl`: This is the command-line tool for using the OpenSSL library, which provides various cryptographic functions.
* `req`: This subcommand specifies that we are working with X.509 Certificate Signing Requests (CSRs) and certificates.
* `-x509`: This option tells openssl to generate a self-signed certificate instead of a certificate signing request (CSR). X.509 is a standard defining the format of public key certificates.
* `-nodes`: This option stands for "no DES" (Data Encryption Standard). It means that the private key will not be encrypted. Without this option, you would be prompted to enter a passphrase to encrypt the private key.
* `-days 365`: This specifies the validity period of the certificate. In this case, the certificate will be valid for 365 days (1 year).
* `-newkey rsa:2048`:This option generates a new private key and a new certificate request. The rsa:2048 part specifies that the key should be an RSA key with a length of 2048 bits.
* -`keyout nginx.key`: This specifies the filename where the generated private key will be saved. In this case, the private key will be saved to nginx.key.
* -`out nginx.crt`: This specifies the filename where the generated self-signed certificate will be saved. In this case, the certificate will be saved to nginx.crt.

