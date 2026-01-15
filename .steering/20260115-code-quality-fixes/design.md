# 設計書: コード品質改善

## 実装アプローチ

各修正を独立して実施し、影響範囲を最小限に抑える。修正ごとに動作確認を行う。

---

## 1. 重複コードの削除

### 変更するコンポーネント
- `templates/shortcodes/codebox.html`

### 変更内容
```diff
  {% set filename = filename | default(value="") %}
  {% set title = title | default(value=filename) %}
  {% set theme = theme | default(value="dark") %}
- {% set title = title | default(value=filename) %}
- {% set theme = theme | default(value="dark") %}
```

### 影響範囲
- `codebox` ショートコードを使用している記事
- 機能への影響なし（重複削除のみ）

---

## 2. .DS_Store ファイルの削除

### 変更するコンポーネント
- Git リポジトリ（キャッシュからの削除）

### 変更内容
```bash
git rm --cached .DS_Store
git rm --cached static/.DS_Store
git rm --cached static/images/.DS_Store
# ... その他の .DS_Store ファイル
```

### 影響範囲
- リポジトリのクリーンアップのみ
- アプリケーション機能への影響なし

---

## 3. CSS互換性の改善

### 変更するコンポーネント
- `sass/main.scss`

### 変更内容
`color-mix()` を使用している各箇所に、フォールバック値を追加する。

```scss
// Before
background: color-mix(in oklab, var(--bg-primary) 97%, var(--text-primary));

// After
background: var(--bg-primary); // Fallback for older browsers
background: color-mix(in oklab, var(--bg-primary) 97%, var(--text-primary));
```

### 実装方針
- 主要な背景色・テキスト色にフォールバックを追加
- CSS変数のベース値をフォールバックとして使用
- 38箇所すべてに対応（優先度に応じて段階的に実施も可）

### 影響範囲
- スタイルシート全体
- 古いブラウザでの表示改善

---

## 4. テンプレートリファクタリング

### 変更するコンポーネント
- `templates/articles/single.html`

### 現状の問題
```html
{% set_global shown = 0 %}
{% for post in section.pages %}
  {% if shown < 3 %}
    {% set_global shown = shown + 1 %}
  {% endif %}
{% endfor %}
```

### 変更内容
Tera テンプレートの制約上、ループ内でのカウンタ管理には `set_global` が必要な場合がある。
代替案として `loop.index` を活用する。

```html
{% for post in related_posts | slice(end=3) %}
  <!-- loop.index で位置を取得 -->
{% endfor %}
```

### 実装方針
- 事前にフィルタリング（`slice`）を行い、ループ内でのカウント不要にする
- スコア計算ロジックは配列操作で事前処理

### 影響範囲
- 関連記事の表示機能
- 表示結果は同一を維持

---

## 5. スタイル適用

### 変更するコンポーネント
- `templates/taxonomy_list.html`

### 現状
```html
<ul>
  {% for term in terms %}
    <li><a href="{{ term.permalink }}">{{ term.name }} ({{ term.pages | length }})</a></li>
  {% endfor %}
</ul>
```

### 変更内容
他のリスト表示と一貫したスタイルを適用する。

```html
<div class="taxonomy-list">
  <ul class="post-list">
    {% for term in terms %}
      <li class="taxonomy-item">
        <a href="{{ term.permalink }}">{{ term.name }}</a>
        <span class="count">({{ term.pages | length }})</span>
      </li>
    {% endfor %}
  </ul>
</div>
```

### 追加CSS（必要に応じて）
```scss
.taxonomy-list {
  // 既存の .post-list スタイルを継承
}

.taxonomy-item {
  // アイテムのスタイル
}
```

### 影響範囲
- タグ一覧ページ、カテゴリ一覧ページの表示
- デザインの統一性向上

---

## データ構造の変更

なし（既存のデータ構造を維持）

---

## 影響範囲の分析

| 修正項目 | 影響範囲 | リスク |
|---------|---------|-------|
| 重複コード削除 | codebox使用記事 | 低 |
| .DS_Store削除 | リポジトリのみ | なし |
| CSS互換性 | 全ページのスタイル | 低 |
| テンプレートリファクタ | 関連記事表示 | 中 |
| スタイル適用 | タクソノミページ | 低 |

---

## 確認方法

各修正後に以下を実施：

```bash
# ビルド確認
zola build

# ローカルサーバーで表示確認
zola serve
```
