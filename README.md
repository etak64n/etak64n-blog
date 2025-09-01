# etak64n-blog

## ローカルで動作させる方法
Zola がインストールされている環境で以下を実行します。

```bash
zola serve
```

ブラウザで <http://127.0.0.1:1111> を開くとプレビューできます。

## Cloudflare Pages にデプロイする方法
Cloudflare Pages の設定で以下を指定します。

- Build command: `zola build`
- Output directory: `public`

GitHub リポジトリと連携すると、push された内容が自動的にデプロイされます。
