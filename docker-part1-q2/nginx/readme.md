###create a self-signed key and certificate pair with OpenSS
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx-selfsigned.key -out nginx-selfsigned.crt


openssl dhparam -out dhparam.pem 2048



we want to test then app then run

curl -k https://127.0.0.1:443


curl -IS -k https://127.0.0.1:443
HTTP/2 200
server: nginx/1.19.10
date: Tue, 06 Jul 2021 07:29:15 GMT
content-type: text/html; charset=utf-8
content-length: 11
strict-transport-security: max-age=63072000; includeSubdomains
x-frame-options: DENY
x-content-type-options: nosniff
