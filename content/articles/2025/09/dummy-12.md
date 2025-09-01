+++
title = "ダミー記事 12 – いろいろなコードブロック集"
date = 2025-09-12
updated = 2025-09-12
draft = false
taxonomies = { tags=["コード","ハイライト","サンプル"], categories=["技術"] }
[extra]
author = "etak64n"
hero = "/images/placeholder.svg"
toc = true
+++

ハイライトとレイアウト確認のために、よく使う言語・ファイル形式のコードブロックをまとめました。ショートコード版（ヘッダー付き）も併記します。

<!-- more -->

## Bash

`Hello, World`
`config.json`

```bash
set -euo pipefail
NAME=${1:-world}
echo "hello, ${NAME}!"
```

```bash
# filename: run.sh
#!/usr/bin/env bash
for i in {1..3}; do echo "${i}"; done
```

## JSON

```json
{
  "ok": true,
  "items": [1, 2, 3],
  "note": "syntax highlight check"
}
```

```json
# filename: config.json
{
  "name": "demo",
  "version": "1.0.0"
}
```

## YAML

```yaml
name: demo
env:
  STAGE: prod
jobs:
  build:
    runs-on: ubuntu-latest
```

## TOML

```toml
title = "Blog"
generate_feeds = false
[markdown]
highlight_code = true
```

## SQL

```sql
SELECT id, name
FROM users
WHERE created_at >= DATE '2025-09-01'
ORDER BY id DESC
LIMIT 20;
```

## Python

```python
from dataclasses import dataclass

@dataclass
class Item:
    id: int
    name: str

items = [Item(1, "a"), Item(2, "b")]
print(items)
```

## TypeScript

```ts
type User = { id: number; name: string };
const users: User[] = [
  { id: 1, name: "Alice" },
  { id: 2, name: "Bob" },
];
console.log(users.map(u => u.name).join(", "));
```

## HCL (Terraform)

```hcl
provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-bucket"
}
```

```hcl
# filename: main.tf
resource "aws_iam_role" "example" {
  name               = "example"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}
```

## HTML

```html
<section class="example">
  <h2>Title</h2>
  <p>Hello <strong>world</strong></p>
</section>
```

## Makefile

```make
.PHONY: build serve clean
build:
	zola build
serve:
	zola serve
clean:
	rm -rf public .zola
```
