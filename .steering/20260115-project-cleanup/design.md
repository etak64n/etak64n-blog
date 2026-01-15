# 設計書: プロジェクト整合性の修正

## 変更概要

本作業では以下の4つの領域を整理します。

```
┌─────────────────────────────────────────────────────────────┐
│                   プロジェクト整合性修正                      │
├──────────────────┬──────────────────┬───────────────────────┤
│  1. 設定同期      │  2. Git整理      │  3. 画像整理          │
│  config.toml     │  385 files       │  processed_images/    │
│  architecture.md │  commit          │  未使用削除           │
├──────────────────┴──────────────────┴───────────────────────┤
│                    4. ビルド検証                             │
│                    zola build                               │
└─────────────────────────────────────────────────────────────┘
```

## 1. 設定ファイルとドキュメントの同期

### 現状分析

**config.toml の変更（未ステージ）:**
```diff
- [markdown]
- render_math = true
- highlight_code = true
- highlight_theme = "base16-ocean-dark"
```

**影響を受ける記事:** 48個のファイルで `math = true` を使用

### 設計方針

**方針: `[markdown]` 設定を復元する**

理由:
- 48個の記事が数式レンダリングを使用
- コードハイライトはほぼ全記事で必要
- 個別記事での設定より、グローバル設定の方が管理しやすい

### 実装内容

#### config.toml（変更を元に戻す）

```toml
base_url = "https://blog.etak64n.dev/"
title = "etak64n's blog"
default_language = "ja"
generate_feeds = false
generate_sitemap = true
build_search_index = false
compile_sass = true

[markdown]
render_math = true
highlight_code = true
highlight_theme = "base16-ocean-dark"

[[taxonomies]]
name = "tags"
render = true
paginate_by = 20

[[taxonomies]]
name = "categories"
render = true
paginate_by = 20
```

#### docs/architecture.md

設定例セクションに `[markdown]` ブロックを追加:

```toml
[markdown]
render_math = true               # 数式レンダリング有効
highlight_code = true            # コードハイライト有効
highlight_theme = "base16-ocean-dark"  # ハイライトテーマ
```

## 2. Git ワーキングツリーの整理

### 変更内容の分類

| 種別 | ファイル数 | 内容 |
|------|-----------|------|
| 削除 | 約234 | 旧構造の記事・画像（`2025/09/` 配下） |
| 追加 | 約151 | 新構造の記事、docs/、CLAUDE.md 等 |
| 変更 | 2 | README.md, config.toml |

### コミット戦略

単一コミットで全変更をまとめる:

```
refactor: カテゴリベースの記事構造に移行

- 記事フォルダ構造を年月ベース（2025/09/）からカテゴリベースに変更
- docs/ に永続的ドキュメントを追加
- CLAUDE.md でプロジェクト規範を定義
- .steering/ による作業管理プロセスを導入
```

### 対象ファイルの確認

ステージング前に以下を確認:
- 削除対象の記事が新構造に移行済みか
- 新規追加ファイルに機密情報が含まれていないか
- `.DS_Store` 等の不要ファイルが含まれていないか

## 3. 処理済み画像の整理

### 現状

`static/processed_images/` に以下が混在:
- 旧構造で使用されていた画像（削除候補）
- 新構造で使用中の画像（保持）

### 設計方針

1. 新構造の記事から参照されている画像を特定
2. 参照されていない画像を削除候補としてリスト化
3. 削除前に確認を実施

### 画像形式の方針

- WebP を優先（軽量、高品質）
- PNG/JPG は元画像として保持可
- 処理済み画像は Zola が自動生成

## 4. ビルド検証

### 検証手順

```bash
# クリーンビルド
rm -rf public/
zola build

# 結果確認
echo $?  # 0 なら成功
```

### 確認項目

- [ ] ビルドエラーなし
- [ ] 警告なし（または許容可能な警告のみ）
- [ ] 全記事の HTML が生成されている
- [ ] 画像参照が正常に解決されている

## 影響範囲

### 変更されるファイル

| ファイル | 変更内容 |
|----------|----------|
| config.toml | `[markdown]` ブロック復元 |
| docs/architecture.md | 設定例に `[markdown]` 追加 |

### 変更されないファイル

- テンプレート（templates/）
- スタイルシート（sass/）
- 記事コンテンツ（content/）※構造変更は既存

## リスクと対策

| リスク | 対策 |
|--------|------|
| ビルド失敗 | 変更前に現状でビルド確認 |
| URL 変更による SEO 影響 | 構造変更は既に完了済み、今回は整理のみ |
| 画像削除による表示崩れ | 削除前に参照チェック |
