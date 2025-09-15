+++
title = "ネットワーク診断 CLI「dstp」の紹介"
date = 2025-09-15
updated = 2025-09-15
draft = false
taxonomies = { tags=["Network", "Tools"], categories=["Tools"] }
[extra]
author = "etak64n"
hero = "/images/hero/hero-terminal.png"
toc = true
+++

## ネットワーク診断 CLI「dstp」の紹介

{{ link(url="https://github.com/ycd/dstp", title="ycd/dstp: 🧪 Run common networking tests against any site.") }}

### インストール & アンインストール

**macOS（Homebrew）**

```
brew install dstp
```

```
brew uninstall dstp
```

{{ link(url="https://formulae.brew.sh/formula/dstp", title="dstp — Homebrew Formulae") }}

### Ping/DNS/SystemDNS/TLS/HTTPS のチェック

ホスト名に対して、`dstp` を実行することができます。

```sh
(๑>ᴗ<) < dstp blog.etak64n.dev
Ping: 11.787ms
DNS: resolving 104.21.48.1
SystemDNS: resolving 104.21.48.1, 104.21.64.1, 104.21.96.1, 104.21.80.1, 104.21.32.1, 104.21.16.1, 104.21.112.1, 2606:4700:3030::6815:1001, 2606:4700:3030::6815:3001, 2606:4700:3030::6815:7001, 2606:4700:3030::6815:6001, 2606:4700:3030::6815:5001, 2606:4700:3030::6815:4001, 2606:4700:3030::6815:2001
TLS: certificate is valid for 76 more days
HTTPS: got 200 OK
```

IP アドレスに対しても `dstp` を実行することができます。

```sh
(๑>ᴗ<) < dstp 8.8.8.8
Ping: 20.448667ms
DNS: resolving 8.8.8.8
SystemDNS: resolving 8.8.8.8
TLS: certificate is valid for 63 more days
HTTPS: got 200 OK
```

- DNS は、dstp が使う既定の DNS リゾルバで引いた時の代表的な名前解決先の1つを表示しています
- SystemDNS は、OS に設定されている DNS で名前解決をした時の結果を表示しています
- TLS は、TLS サーバー証明書の残り日数を表示しています

### JSON 形式での出力

```sh
(๑>ᴗ<) < dstp --o json blog.etak64n.dev
{
  "dns": "resolving 104.21.16.1",
  "https": "got 200 OK",
  "ping": "12.12ms",
  "system_dns": "resolving 104.21.16.1, 104.21.64.1, 104.21.112.1, 104.21.96.1, 104.21.48.1, 104.21.32.1, 104.21.80.1, 2606:4700:3030::6815:3001, 2606:4700:3030::6815:5001, 2606:4700:3030::6815:1001, 2606:4700:3030::6815:2001, 2606:4700:3030::6815:4001, 2606:4700:3030::6815:7001, 2606:4700:3030::6815:6001",
  "tls": "certificate is valid for 76 more days"
}
```

### ポートを指定して TLS 通信

```sh
(๑>ᴗ<) < dstp --port 8080 blog.etak64n.dev
Ping: 11.506666ms
DNS: resolving 104.21.16.1
SystemDNS: resolving 104.21.16.1, 104.21.64.1, 104.21.112.1, 104.21.96.1, 104.21.48.1, 104.21.32.1, 104.21.80.1, 2606:4700:3030::6815:3001, 2606:4700:3030::6815:5001, 2606:4700:3030::6815:1001, 2606:4700:3030::6815:2001, 2606:4700:3030::6815:4001, 2606:4700:3030::6815:7001, 2606:4700:3030::6815:6001
TLS: tls: first record does not look like a TLS handshake
HTTPS: Get "https://blog.etak64n.dev:8080": http: server gave HTTP response to HTTPS client
```

### DNS リゾルバを指定して名前解決

```sh
(๑>ᴗ<) < dstp --dns 8.8.8.8 blog.etak64n.dev
Ping: 10.135ms
DNS: resolving 104.21.16.1
SystemDNS: resolving 104.21.32.1, 104.21.48.1, 104.21.16.1, 104.21.80.1, 104.21.96.1, 104.21.112.1, 104.21.64.1, 2606:4700:3030::6815:6001, 2606:4700:3030::6815:5001, 2606:4700:3030::6815:4001, 2606:4700:3030::6815:2001, 2606:4700:3030::6815:7001, 2606:4700:3030::6815:3001, 2606:4700:3030::6815:1001
TLS: certificate is valid for 76 more days
HTTPS: got 200 OK
```

## まとめ
使った感想としては、`ping`、`dig`、`nslookup`、`curl -I` などをまとめて実行してくれるツールという印象です。