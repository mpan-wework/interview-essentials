---
title:  "HTTP Authentication"
date:   "2020-03-23 00:00:00+08:00"
tags: [backend]
pull_request_id: 2
---

> 中文版在英文版之后。

# HTTP Authentication

> `AAA` is the abbreviation for `Authentication`,`Authorization` and `Accounting`, in other words, validating you are exactly you, validating you have permission to operate over specific resources and charging you on your operations over those resources.

~~~
POST /users/login
GET /users/:uid/invoices
POST /users/:uid/invoices/:id/payments
~~~

Consider our business logics: login, fetch invoices and invoke invoice payment.

Due to `HTTP`'s statelessness, when `GET /users/:uid/invoices` and `POST /users/:uid/invoices/:id/payments` received, Server needs to figure out the caller is exactly the one calling `POST /users/login`. Currently there are two common solutions.

First solution: `session`
1. Client calls `POST /users/login`
1. Server creates a `session` and sends `session_id` and `expiration time` back to Client in `Set-Cookie` header of `HTTP Response`
1. Client calls API with `session_id` in `Cookie` header
1. Server looks in session pool for a `session` with `session_id` to validate user's identity

`session` on Server has `expiration time` and will be destroyed after expired.

Second solution: `token`
1. Client calls `POST /users/login`
1. Server issues a pair of encrypted `access token` (including user information and `expiration time`) and `refresh token`, and sends back to Client in `body` of `HTTP Response`
1. Client calls API with `access token` in `Authorization` header
1. Server decrypts `access token` and extracts user information to validate user's identity

`access token` has `expiration time`, and it cannot be used for authentication and calling API after expired. However, Client can call `POST /token/refresh` with `refresh token` to apply for a new pair of `access token` and `refresh token`.

# HTTP 鉴权

> `AAA` 是 `Authentication`、`Authorization`、`Accounting` 的缩写，通俗的说就是，验证你是你，验证你有权限对某个资源进行操作，对你操作资源的行为进行计费。

~~~
POST /users/login
GET /users/:uid/invoices
POST /users/:uid/invoices/:id/payments
~~~

考虑我们的业务逻辑：登陆，获取账单，唤起支付。

由于 `HTTP` 无状态，在调用 `GET /users/:uid/invoices` 和 `POST /users/:uid/invoices/:id/payments` 的时候，服务器需要确认，调用方是之前调用 `POST /users/login`。目前有两种常见的做法。

第一种：`session`
1. 客户端调用 `POST /users/login`
1. 服务端创建一个 `session` 并得到一个 `session_id` 和 `expiration time`，在 `HTTP Response` 的 `Set-Cookie` 头里返回给客户端
1. 客户端后续调用 API 时，在 `Cookie` 头里带上 `session_id`
1. 服务端会进行查询验证 `session_id` 的 `session` 是否存在，从而确认客户端的身份

服务端的 `session` 有 `expiration time`，过期之后自动销毁。

第二种: `token`
1. 客户端调用 `POST /users/login`
1. 服务端颁发一对包含用户信息的加密过的 `access token` (包含 `expiration time`) 和 `refresh token`，在 `HTTP Response` 的 `body` 里返回给客户端
1. 客户端后续调用 API 时，在 `Authorization` 头里带上 `access token`
1. 服务端解密 `access token` 得到用户信息，从而确认客户端的身份

`access token` 本身具有 `expiration time`，过期之后，`access token` 不再具有验证身份的功能，也就无法继续调用其他 API，此时可以通过 `POST /token/refresh` 带上 `refresh token` 向服务端申请重新颁发一对 `access token` 和 `access token`。
