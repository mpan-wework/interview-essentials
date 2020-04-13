---
title:  "SSL/TLS in HTTPS and Database"
date:   "2020-04-13 00:00:00+08:00"
tags: [backend, frontend, security]
pull_request_id: 5
---

# `SSL/TLS` in `HTTPS` and Database

## Public Key and Private Key

Every message can be sent in plain text. However, if we would like to prevent someone else's attack of stealing information or pretending to be sender/receiver, we have to encrypt messages when sending and decrypt messages when receiving.

`public key` and `private key` are generated in pairs and both can be used to encrypt/decrypt messages. That is, messages can be encrypted into concealed strings by `public key` and concealed strings can be decrypted back to messages by `private key`, and vice versa. There are commonly two use cases.

1. Key pair is generated by receiver so `private key` is saved at receiver and `public key` is distributed to multiple senders. Receiver deploys one single `private key` so that all senders can communicate to it.

1. Key pair is generated by sender so `private key` is saved at sender and `public key` is distributed to multiple receivers. Every receiver can use `public key` to decrypt a message and validate the message is sent from sender. This is useful in terms of signature.

## HTTPS

`HTTPS` means secure `HTTP`.

Here we simulate visiting `https://www.github.com` through `cURL` commands to see what happens.

<details>
  <summary>HTTPS interaction</summary>

<pre>
#!/bin/bash -eo pipefail
curl -X GET 'https://www.github.com' -v
Note: Unnecessary use of -X or --request, GET is already inferred.
* Rebuilt URL to: https://www.github.com/
*   Trying 140.82.112.3...
* TCP_NODELAY set
* Connected to www.github.com (140.82.112.3) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* Cipher selection: ALL:!EXPORT:!EXPORT40:!EXPORT56:!aNULL:!LOW:!RC4:@STRENGTH
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: /etc/ssl/certs
* TLSv1.2 (OUT), TLS header, Certificate Status (22):
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Client hello (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-AES128-GCM-SHA256
* ALPN, server accepted to use http/1.1
* Server certificate:
*  subject: businessCategory=Private Organization; jurisdictionC=US; jurisdictionST=Delaware; serialNumber=5157550; C=US; ST=California; L=San Francisco; O=GitHub, Inc.; CN=github.com
*  start date: May  8 00:00:00 2018 GMT
*  expire date: Jun  3 12:00:00 2020 GMT
*  subjectAltName: host "www.github.com" matched cert's "www.github.com"
*  issuer: C=US; O=DigiCert Inc; OU=www.digicert.com; CN=DigiCert SHA2 Extended Validation Server CA
*  SSL certificate verify ok.
> GET / HTTP/1.1
> Host: www.github.com
> User-Agent: curl/7.52.1
> Accept: */*
> 
< HTTP/1.1 301 Moved Permanently
< Content-length: 0
< Location: https://github.com/
< 
* Curl_http_done: called premature == 0
* Connection #0 to host www.github.com left intact

#!/bin/bash -eo pipefail
curl -X GET 'https://github.com' -v
Note: Unnecessary use of -X or --request, GET is already inferred.
* Rebuilt URL to: https://github.com/
*   Trying 140.82.112.3...
* TCP_NODELAY set
* Connected to github.com (140.82.112.3) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* Cipher selection: ALL:!EXPORT:!EXPORT40:!EXPORT56:!aNULL:!LOW:!RC4:@STRENGTH
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: /etc/ssl/certs
* TLSv1.2 (OUT), TLS header, Certificate Status (22):
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Client hello (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-AES128-GCM-SHA256
* ALPN, server accepted to use http/1.1
* Server certificate:
*  subject: businessCategory=Private Organization; jurisdictionC=US; jurisdictionST=Delaware; serialNumber=5157550; C=US; ST=California; L=San Francisco; O=GitHub, Inc.; CN=github.com
*  start date: May  8 00:00:00 2018 GMT
*  expire date: Jun  3 12:00:00 2020 GMT
*  subjectAltName: host "github.com" matched cert's "github.com"
*  issuer: C=US; O=DigiCert Inc; OU=www.digicert.com; CN=DigiCert SHA2 Extended Validation Server CA
*  SSL certificate verify ok.
> GET / HTTP/1.1
> Host: github.com
> User-Agent: curl/7.52.1
> Accept: */*
> 
< HTTP/1.1 200 OK
< server: GitHub.com
< date: Sun, 12 Apr 2020 11:55:57 GMT
< content-type: text/html; charset=utf-8
< status: 200 OK
< vary: X-PJAX, Accept-Encoding, Accept, X-Requested-With
< etag: W/"733b034e75b8d551cf1e3fdc5c56b436"
< cache-control: max-age=0, private, must-revalidate
< strict-transport-security: max-age=31536000; includeSubdomains; preload
< x-frame-options: deny
< x-content-type-options: nosniff
< x-xss-protection: 1; mode=block
< referrer-policy: origin-when-cross-origin, strict-origin-when-cross-origin
< expect-ct: max-age=2592000, report-uri="https://api.github.com/_private/browser/errors"
< content-security-policy: default-src 'none'; base-uri 'self'; block-all-mixed-content; connect-src 'self' uploads.github.com www.githubstatus.com collector.githubapp.com api.github.com www.google-analytics.com github-cloud.s3.amazonaws.com github-production-repository-file-5c1aeb.s3.amazonaws.com github-production-upload-manifest-file-7fdce7.s3.amazonaws.com github-production-user-asset-6210df.s3.amazonaws.com wss://live.github.com; font-src github.githubassets.com; form-action 'self' github.com gist.github.com; frame-ancestors 'none'; frame-src render.githubusercontent.com; img-src 'self' data: github.githubassets.com identicons.github.com collector.githubapp.com github-cloud.s3.amazonaws.com *.githubusercontent.com customer-stories-feed.github.com spotlights-feed.github.com; manifest-src 'self'; media-src 'none'; script-src github.githubassets.com; style-src 'unsafe-inline' github.githubassets.com
< Set-Cookie: _gh_sess=sWnj5kDp5HoCSRnTgl6zGZTN1IBCkabYjsMu0YQL%2BuRKWEyUdlPqFGiBNq1TKBEYfFewNI8RyOzspgcTkroCZt5F0%2FtWy0NBsD1eke48SOLwP7vnX9bHtCrIzYWNhNPxyuijk4%2BkTspQUPF9Zm%2Bbm11BcXpN6hh6BNGip9SENGLL53HfofQpUgE0Ci90O%2BHB3Efw5BS2c2SCUZyfAZ1jDhPUIRrGeDSCQfVStFkCRgxzhZ88pq1VxqH1gSfOAvhmD5gIQdvRzqyGHTqGvNh%2BJA%3D%3D--6PFQFCzBBMJbeneY--ZoJGwLzowJNMAjXlaj4Eqw%3D%3D; Path=/; HttpOnly; Secure
< Set-Cookie: _octo=GH1.1.468749185.1586692563; Path=/; Domain=github.com; Expires=Mon, 12 Apr 2021 11:56:03 GMT; Secure
< Set-Cookie: logged_in=no; Path=/; Domain=github.com; Expires=Mon, 12 Apr 2021 11:56:03 GMT; HttpOnly; Secure
< Accept-Ranges: bytes
< Transfer-Encoding: chunked
< X-GitHub-Request-Id: A04C:2D8B:216E1A:36365C:5E9301D3
< 

...

* Curl_http_done: called premature == 0
* Connection #0 to host github.com left intact
</pre>

</details>

1. Client tries to find ip address (`140.82.112.3`) of `www.github.com` throught `DNS`;

1. Client starts to send messages to `140.82.112.3` at port `443` since we are using `HTTPS` scheme (`80` for `HTTP`);

1. Client initiates `ALPN` (Application-Layer Protocol Negotiation) with Server to offer to use either `http2` or `http/1.1`;

1. Client sets up `CA` (Certification Authority) cert;

    Here we have our first terminology `CA` (Certification Authority).
    
    `CA` is an authority who issues certificates to other websites, just like a government department issuing ID cards to its country's citizens. It can be global, regional or even self-owned as long as we choose to trust them, e.g. Chrome browser has its own `CA` list, which means Chrome only trusts certificates issued by `CA`s in the list.

    Then we have our second terminology `certificate`.

    `CA`'s certificate is `CA`'s `public key` (`ca.pub`). Client has `ca.pub`, which means Client can reveal any messages encrypted by `CA`'s `private key` (`ca.key`). `CA` issues certificates by encrypting a set of messages with `ca.key`. 

1. Client attempts to initiate a connection through a `hello` message over `TLSv1.2`;

    `SSLv1.0` is unpublished. `SSLv2.0`, `SSLv3.0`, `TLSv1.0` and `TLSv1.1` are deprecated. `TLSv1.2` and `TLSv1.3` are currently in use.

1. Server sends back a `hello` message along with its certificate (containing its `public key`, `server.pub`) issued by `CA`;

    Server generates a pair of `public key` (`server.pub`) and `private key` (`server.key`) and `server.key` is only saved on Server. Client needs to encrypt messages with `server.pub` before sending to Server so that nobody else but Server can reveal the messages with `server.key`.

    Client, as above said, validates whether the certificate is issued by its trusted `CA`s (`DigiCert SHA2 Extended Validation Server CA`) and whether the host matches (`www.github.com`).

1. Client sends its `public key` (`client.pub`) encrypted with `server.pub` and a `hello` message encrypted with `client.key` to Server;

    Client generates a pair of `public key` (`client.pub`) and `private key` (`client.key`) and `client.key` is only saved on Client. When sending afterward messages, Client will encrypt with `client.key` so that Server can decrypt with `client.pub`.

1. Server validates it can decrypt `hello` message with `client.pub` and reaches agreement with Client about message encryption/decryption;

    At this point, Client holds `client.key` for message encryption while Server holds `client.pub` for message decryption. Since key pair is proposed by Client, Server can validate it is exactly Client who is attempting to perform operations over its own resources.

1. Server reaches agreement with Client about `ALPN` to use `http/1.1`;

1. Client sends `GET` request and receives `301` to redirect to another location `https://github.com`;

1. Client repeats above process except that the host changes from `https://www.github.com` to `https://github.com` and finally receives the content;

In above example, we assume asymmetric encryption/decryption (e.g. `RSA`) is always enforced, which means `public key` is not the same as `private key`. There is also symmetric encryption/decryption, which means both sides use identical `secret key` to encrypt and decrypt messages. Usually asymmetric algorithms are more secure but slower.

`client.pub` and `client.key` is actually symmetric in above example (`AES`), which is a simple trade-off between speed and security.

## Database

When accessing production database, we are likely to be asked to provide `ca.pem`, `cert.pem` and `key.pem`.

* `ca.pem` (`CA`'s certificate) to announce that certificates issued by `CA` are trusted;
* `cert.pem` (issued by `CA`) to annouce identity;
* `key.pem` (our `private key`) to encrypt messages;

## Reference

1. [How does HTTPS work](https://www.youtube.com/watch?v=T4Df5_cojAs)
1. [TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security#Secure_Data_Network_System)