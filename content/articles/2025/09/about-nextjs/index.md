+++
title = "Next.js について"
date = 2025-09-22
updated = 2025-09-22
draft = false
taxonomies = { tags=["Next.js"], categories=["Next.js"] }
[extra]
author = "etak64n"
hero = "/images/hero/placeholder.svg"
toc = true
+++

## Next.js について

Next.js は Vercel 社が開発した React ベースのフレームワークです。

{{ link(url="https://nextjs.org/", title="Next.js by Vercel - The React Framework") }}

### Next.js が生まれた背景
Facebook (現Meta) が開発した UI ライブラリ React には以下のような課題がありました。

* ルーティングがない
  * `react-router` など外部ライブラリが必要
* SSR/SSG が標準サポートされない
  * 自前でセットアップする必要がある
* 設定が複雑
  * Webpack や Babel の設定を毎回自分でやる必要があった
* SEO 対策が弱い
  * 初期表示が CSR（空の HTML から JS 実行で描画）になる

そこで Vercel（当時 Zeit） が 2016 年に Next.js を公開しました。
* 「設定不要で動く React アプリ」
  * create-next-app で即座に開発開始できる。
* SSR/SSG の統合
  * SEO に強く、表示も高速に。
* フルスタック構成
  * API Routes を備えて、フロントとバックエンドを 1 つのリポジトリで完結できる。
* パフォーマンス最適化の自動化
  * コード分割・画像最適化・フォント最適化を標準搭載。

### Next.js の利点
* 1つのリポジトリでサーバーとクライアントの両方を扱える

### Next.js を使う場合の構成

#### パターンA：Next.jsだけで完結
App Router + Server Components + API Routes
小〜中規模向け

```sh
repo/
├─ app/
│  ├─ (routes)/
│  │  └─ todos/
│  │     ├─ page.tsx          # Server Component (default)
│  │     └─ client.tsx        # Client Component ("use client")
│  ├─ api/
│  │  └─ todos/route.ts       # API Route (server-only)
│  ├─ layout.tsx
│  └─ page.tsx
├─ lib/
│  ├─ db.ts                    # DB client (Prisma/Drizzle etc.)
│  └─ services/                # business logic layer
├─ prisma/                     # if Prisma
├─ .env                        # server-only secrets
├─ .env.local                  # local overrides
├─ package.json
└─ tsconfig.json
```
### Next.js の処理の流れ

Next.js の処理の流れは Next.js のドキュメントに記載されています。 {{ ref(url="https://nextjs.org/docs/app/api-reference/file-conventions/middleware", title="Routing: Middleware | Next.js", excerpt="The following is the execution order:") }} {{ ref(url="https://nextjs.org/docs/app/api-reference/config/next-config-js/rewrites", title="next.config.js: rewrites | Next.js", excerpt="The order Next.js routes are checked is:") }}

1. `headers` (next.config)
  事前にルール化された固定ヘッダーをレスポンスに付与します。
  サーバーリクエストに追加で付与するのではなく、最終的に返すレスポンスに付与する点に注意です。
1. `redirects` (next.config)
  事前にルール化されたリダイレクト設定で、リダイレクトを行います。
  `/old` を `/new` にリダイレクトする、という設定例がわかりやすいです。
1. Middleware（ `middleware.ts` ）
  認証ガード、A/B テスト、言語/地域振り分け、Bot/UAブロック、簡易メンテナンスモード等
1. `rewrites() { return beforeFiles[]; }`（next.config）
  `rewrites()` は、特定のパスを別のパスへ書き換える処理となります。
  next.config で定義された `rewrites()` 関数に従い、`beforeFiles[]` を返します。
  サーバー側のルーティングよりも先に処理が行われ、サーバー側の実装よりも優先されるルーティング設定となります。
1. ファイルシステムの照合
  `public/`、`_next/static/`、App Router/Pages Router のルーティング設定に応じてルーティングを行います。

1. `rewrites() { return afterFiles[]; }`（next.config）
  `rewrites()` は、特定のパスを別のパスへ書き換える処理となります。
  next.config で定義された `rewrites()` 関数に従い、`afterFiles[]` を返します。
  サーバー側のルーティング処理の後に行われるため、サーバー側で処理できないものを外部のパスへルーティングするイメージです。

1. 動的ルートの照合（例：`/blog/[slug]`）
   App Router の場合は `app/blog/[slug]/page.tsx` のようなページ
   Pages Router の場合は `pages/blog/[slug].tsx` のようなページ

1. `rewrites() { return fallback[]; }`（next.config）
  `rewrites()` は、特定のパスを別のパスへ書き換える処理となります。
  next.config で定義された `rewrites()` 関数に従い、`fallback[]` を返します。
  どれにも当たらない URL を最終的に拾いたい、というユースケースで使われます。

1. ルート解決 → レンダリング（app/*/page.tsx / Route Handler 等）

#### headers(), redirects()
Next.js はまず next.config の `headers()`, `redirects()` の処理を行います。
next.config の実態はプロジェクトルートの以下の3つのファイルのいずれかとなります。 {{ ref(url="https://nextjs.org/docs/app/api-reference/config/next-config-js", title="Configuration: next.config.js | Next.js", excerpt="Next.js can be configured through a `next.config.js` file in the root of your project directory (for example, by `package.json`) with a default export.") }}

* `next.config.js` (CommonJS) {{ ref(url="https://nextjs.org/docs/app/api-reference/config/next-config-js", title="Configuration: next.config.js | Next.js", excerpt="Next.js can be configured through a `next.config.js` file in the root of your project directory (for example, by `package.json`) with a default export.") }}
* `next.config.mjs` (ES Modules) {{ ref(url="https://nextjs.org/docs/app/api-reference/config/next-config-js", title="Configuration: next.config.js | Next.js", excerpt="If you need ECMAScript modules, you can use `next.config.mjs`.") }}
* `next.config.tjs` (TypeScript) {{ ref(url="https://nextjs.org/docs/app/api-reference/config/next-config-js", title="Configuration: next.config.js | Next.js", excerpt="If you are using TypeScript in your project, you can use `next.config.ts` to use TypeScript in your configuration.") }}

{% note(type="alert") %}
<code>.cjs</code>、<code>.cts</code>、<code>.mts</code> などはサポートされていません。 {% ref(url="https://nextjs.org/docs/app/api-reference/config/next-config-js", title="Configuration: next.config.js | Next.js") %}
**Good to know**: next.config with the `.cjs`, `.cts`, or `.mts` extensions are currently not supported.
{% end %}
{% end %}

`next.config.js` の具体的なコードの例です。

```js
// next.config.js
/** @type {import('next').NextConfig} */
module.exports = {
  reactStrictMode: true,
  compress: true,
  trailingSlash: false,
  poweredByHeader: false,

  async headers() {
    return [
      {
        source: "/:path*",
        headers: [
          { key: "X-Content-Type-Options", value: "nosniff" },
        ],
      },
      {
        source: "/_next/static/:path*",
        headers: [{ key: "Cache-Control", value: "public, max-age=31536000, immutable" }],
      },
    ];
  },

  async redirects() {
    return [{ source: "/old", destination: "/new", permanent: true }];
  },

  async rewrites() {
    return [{ source: "/api/:path*", destination: "https://bff.example.com/:path*" }];
  },
};
```

`headers()`、`redirects()` からルーティングを作成する実装は [next.js/packages/next/src/lib/load-custom-routes.ts](https://github.com/vercel/next.js/blob/canary/packages/next/src/lib/load-custom-routes.ts") です。


#### middleware.ts

プロジェクトのルートにある `middleware.ts` というファイルを使います {{ ref(url="https://nextjs.org/docs/13/app/building-your-application/routing/middleware", title="Routing: Middleware | Next.js", excerpt="Use the file `middleware.ts` (or `.js`) in the root of your project to define Middleware.") }} {{ ref(url="https://nextjs.org/docs/app/api-reference/file-conventions/middleware", title="File-system conventions: middleware.js | Next.js", excerpt="Create a `middleware.ts` (or `.js`) file in the project root, or inside `src` if applicable, so that it is located at the same level as `pages` or `app`.") }}

`middleware.ts` は、`middleware()` という名称の関数あるいは default で指定された関数(関数名は自由)をエクスポートする必要があります。 {{ ref(url="https://nextjs.org/docs/app/api-reference/file-conventions/middleware", title="File-system conventions: middleware.js | Next.js", excerpt="The file must export a single function, either as a default export or named `middleware`. Note that multiple middleware from the same file are not supported.") }}

`middleware.ts` の具体的なコードです。

```ts
// middleware.ts
import type { NextRequest } from "next/server";
import { NextResponse } from "next/server";

export const config = {
  // 保護対象だけに絞る（静的アセット等に当てない）
  matcher: ["/dashboard/:path*", "/settings/:path*", "/api/private/:path*"],
};

export function middleware(req: NextRequest) {
  const { nextUrl } = req;
  const session = req.cookies.get("session")?.value;

  if (!session) {
    // API は 401, ページは /login へリダイレクト
    if (nextUrl.pathname.startsWith("/api"))
      return new NextResponse("Unauthorized", { status: 401 });

    const url = new URL("/login", req.url);
    url.searchParams.set("from", nextUrl.pathname + nextUrl.search);
    return NextResponse.redirect(url);
  }

  return NextResponse.next();
}
```

`/dashboard` や `/settings`、`/api/private` のパスが保護されています。
リクエストの Cookie から `session` を確認し、`session` がなければ未認証という扱いで処理をします。
`/api` は `401 Unauthorized` が表示され、他のページは `/login` へリダイレクトします。
別のログイン処理で `session` を発行して、Cookie に付与する実装です。

`middleware.ts` からルーティングを作成する実装は [next.js/packages/next/src/lib/load-custom-routes.ts](https://github.com/vercel/next.js/blob/canary/packages/next/src/lib/load-custom-routes.ts") です。

#### rewrites(): beforeFiles[]

`rewrites()` は、特定のパスを別のパスへ書き換える処理となります。
next.config で定義された `rewrites()` 関数に従い、`beforeFiles[]` を返します。
サーバー側のルーティングよりも先に処理が行われ、サーバー側の実装よりも優先されるルーティング設定となります。

```js
// next.config.js
/** @type {import('next').NextConfig} */
module.exports = {
  async rewrites() {
    return {
      beforeFiles: [{ source: "/api/:path*", destination: "https://bff.example.com/:path*" }],
      afterFiles: [],
      fallback: [],
    };
  },
};
```

**ユースケース**

1. メンテナンス中はメンテナンスページへ飛ばす
  全てのパスに対して `/maintenance` ページへルーティングすることで、アプリ側のルーティングが発生しないため、速度が速い

1. 画像を CDN 経由にさせる
  `/img/` といったパスは `https://cdn.example.com/img/` へ飛ばすことで、ローカルに画像があっても使わせずに CDN を強制させ、ローカルデータの誤配信を防ぐ

1. レガシー移行
  `/legacy/` といったパスに対して、`https://legacy.example.com/` へルーティングすることで、新しいアプリ移行時に未実装処理を旧アプリ側で処理させる

`rewrites()` からルーティングを作成する実装は [next.js/packages/next/src/lib/load-custom-routes.ts](https://github.com/vercel/next.js/blob/canary/packages/next/src/lib/load-custom-routes.ts") です。


#### ファイルシステムの照合

* Pages Router を使っている場合 `pages/` のルーティングから `next build` で `pages-manifest.json` を作成します。
* App Router を使っている場合 `app/` のルーティングから `next build` で `app-paths-manifest.json` を作成します。
* `public` ディレクトリ内のファイルはそのまま1対1対応するルートが作成されます ( `public/avatars/me.png` は `/avatars/me.png` ) {% ref(url="https://nextjs.org/docs/app/api-reference/file-conventions/public-folder", title="File-system conventions: public | Next.js") %} Files inside public can then be referenced by your code starting from the base URL (/). {% end %}
* `/_next/static/*` 等のビルド成果物 (ビルドで出た静的アセット)

これらのルーティングでページを決定します。

#### rewrites(): afterFiles[]

`rewrites()` は、特定のパスを別のパスへ書き換える処理となります。
next.config で定義された `rewrites()` 関数に従い、`afterFiles[]` を返します。
サーバー側のルーティング処理の後に行われるため、サーバー側で処理できないものを外部のパスへルーティングするイメージです。

```js
// next.config.js
/** @type {import('next').NextConfig} */
module.exports = {
  async rewrites() {
    return {
      beforeFiles: [],
      afterFiles: [{ source: "/api/:path*", destination: "https://bff.example.com/:path*" }],
      fallback: [],
    };
  },
};
```

`afterFiles` は `rewrites()` の中でも一番汎用的なユースケースになるので、明示的に `afterFiles` を指定せずに使うことができます。

```ts
async rewrites() {
  return [{ source: "/api/:path*", destination: "https://bff.example.com/:path*" }]; // = afterFiles
}
```

`rewrites()` からルーティングを作成する実装は [next.js/packages/next/src/lib/load-custom-routes.ts](https://github.com/vercel/next.js/blob/canary/packages/next/src/lib/load-custom-routes.ts") です。

#### 動的ルートの照合

#### rewrites(): fallback[]

`rewrites()` は、特定のパスを別のパスへ書き換える処理となります。
next.config で定義された `rewrites()` 関数に従い、`fallback[]` を返します。
どれにも当たらない URL を最終的に拾いたい、というユースケースで使われます。

```ts
// next.config.js
/** @type {import('next').NextConfig} */
module.exports = {
  async rewrites() {
    return {
      beforeFiles: [],
      afterFiles: [],
      fallback: [{ source: "/:path*", destination: "/app" }],
    };
  },
};
```

`rewrites()` からルーティングを作成する実装は [next.js/packages/next/src/lib/load-custom-routes.ts](https://github.com/vercel/next.js/blob/canary/packages/next/src/lib/load-custom-routes.ts") です。

### Next.js のビルド後のファイル

`next build` を実行すると `.next/` ディレクトリが作成されます。

.next/ に入る主なもの（代表例）
static/：クライアント向けに配信されるビルド済みアセット（JS/CSS など）
server/：サーバー側出力（App Router/Pages のサーバーコード、エントリ、各種マニフェスト）
マニフェスト各種（JSON）
ルーティング・リライト・リダイレクト等の規則表：routes-manifest.json
ミドルウェアのマッチャー等：server/middleware-manifest.json
App/Pages のパス対応：server/app-paths-manifest.json / server/pages-manifest.json
クライアントのチャンク表：build-manifest.json / app-build-manifest.json
SSG/ISR 情報：prerender-manifest.json
cache/：ビルドキャッシュ（環境によって有無・構成が変わります）
バージョンや設定によってファイル名・配置は多少変わります（上は“よくある”例）。


### Next.js の処理の流れ(ビルド/起動)

これらの設定は `next build` された後に `.next` にマニフェスト(JSON)として保存されます。

* `.next/routes-manifest.json`
  * headers / redirects / rewrites の静的ルール表が入ります。
* `.next/server/middleware-manifest.json`
  * プロジェクトに middleware.ts がなくても、実行時に参照されるマニフェスト
* `.next/server/app-paths-manifest.json`（App Router）
* `.next/server/pages-manifest.json`（Pages Router）
  * app/ または pages/ の URL ↔ ファイル 対応表。環境やバージョンによって、片方/両方が出ます。
*  `/_next/build-manifest.json`（配信パス）
*  `.next/app-build-manifest.json` など
  * クライアントの JS チャンク対応表（next/link のプリフェッチ等が利用）。
* `.next/prerender-manifest.json`
  * SSG/ISR の出力と再検証情報（サイト構成により中身は最小/空に近い場合あり）。

```json
// .next/routes-manifest.json
{
  "version": 5,
  "basePath": "",
  "headers": [
    {
      "source": "/:path*",
      "headers": [
        { "key": "x-content-type-options", "value": "nosniff" }
      ]
    },
    {
      "source": "/_next/static/:path*",
      "headers": [
        { "key": "cache-control", "value": "public, max-age=31536000, immutable" }
      ]
    }
  ],
  "redirects": [
    {
      "source": "/old",
      "destination": "/new",
      "statusCode": 308
    }
  ],
  "rewrites": {
    "beforeFiles": [],
    "afterFiles": [
      {
        "source": "/api/:path*",
        "destination": "https://bff.example.com/:path*"
      }
    ],
    "fallback": []
  }
}
```

---

Self Hosted Server の場合は `.next/routes-manifest.json` 

自己ホスト（next start）

next build 時に .next/routes-manifest.json が生成されます。

本番サーバ（Next.js の Node サーバ）が 起動/実行時にこのファイルを読み、redirects / rewrites / headers などを適用します。
→ この種のマニフェストが見つからないと実行時エラーになる事例があります（同系の pages-manifest.json/middleware-manifest.json を Next 本体が要求）。
GitHub
+1

Vercel などの PaaS

デプロイ時に ビルド出力（.next）をプラットフォームが取り込み、その中のルーティング情報（routes-manifest.json）を自社のルーティング設定へ変換して配備します。
→ .next/routes-manifest.json が無いと Vercel 側でエラーになります（＝プラットフォームが参照している証拠）。
Vercel
+1

変換後は Vercel の“Build Output API” の routes 設定としてデプロイに適用され、Edge でのルーティングに反映されます。元ファイルそのものを Edge POP に配るわけではありません。 
Vercel

なぜ「Edge に置かれない」と言える？

Edge Runtime では Node の fs などファイルシステム API は使えません。Edge 関数が .next 内のローカルファイルを直接読む設計ではなく、プラットフォーム（または Node サーバ）が事前に“規則”へ落として適用します。
Next.js

### Edge 環境
コンピュート平面が分かれている：
Node Functions（サーバレス/コンテナ系） と
Edge Functions（POPに分散配置） が 別インフラで最適化されている。

実行場所の違い：
Edge: ユーザーに近いPOPで実行 → 低レイテンシ・起動が速いが、Node API不可・実行時間やメモリは小さめ。
Node: リージョン固定（例：iad1/apne1等）→ 機能は豊富で DB/TCP も扱いやすいが、レイテンシはリージョン距離に依存。

Client → (CDN/Edge) → [Middleware/Edge Functionsがあれば実行]
       → Node Functions（必要なら） → Route Handlers/SSR
