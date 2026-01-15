# 設計

## 変更ファイル
- `config.toml` - シンタックスハイライトテーマ設定
- `sass/main.scss` - スタイル定義
- `templates/base.html` - コピーボタンのJS処理

## 詳細設計

### 1. シンタックスハイライトテーマ変更

**ファイル**: `config.toml`

```toml
[markdown.highlighting]
theme = "nord"  # material-theme-ocean から変更
```

**選定理由**: 北欧風の落ち着いた青みがかったグレーで、目に優しい色合い

### 2. インラインコードのスタイル

**ファイル**: `sass/main.scss`

#### ライトモード
```scss
.content :not(pre) > code {
  background: #dbeafe;      // 薄い青
  border: 1px solid #93c5fd; // 青いボーダー
  color: #dc2626;            // 赤い文字
  padding: 0.05em 0.25em;    // 狭いpadding
  border-radius: 3px;        // 少し角丸
}
```

#### ダークモード
```scss
:root[data-theme='dark'] .content :not(pre) > code {
  background: rgba(96,165,250,0.3);  // 明るい青系半透明
  border-color: rgba(96,165,250,0.4);
  color: #f87171;                     // 明るい赤
}
```

### 3. コードブロックの角丸

**ファイル**: `sass/main.scss`

- `pre`: `border-radius: 4px`
- `.codebox`: `border-radius: 4px`
- `.codebox-pre`: `border-radius: 4px`
- `.codebox.dark .codebox-pre`: `border-radius: 4px`
- `.codebox-copy`: `border-radius: 4px`

### 4. コピーボタンの改善

#### 4.1 位置固定（横スクロール対応）

**ファイル**: `templates/base.html`

変更前: ボタンを`.codebox-pre`内に追加
```javascript
preClone.appendChild(btn);
```

変更後: ボタンを`.codebox`（wrapper）に追加
```javascript
wrapper.appendChild(preClone);
wrapper.appendChild(btn);
```

#### 4.2 フェードアニメーション

**ファイル**: `sass/main.scss`

```scss
.codebox-copy {
  transition: opacity 200ms ease, visibility 200ms ease;
}

.codebox:hover .codebox-copy {
  opacity: 0.9;
  visibility: visible;
}
```

#### 4.3 コピー完了後のアイコン切り替え

**ファイル**: `templates/base.html`

```javascript
setTimeout(() => {
  btn.classList.remove('copied'); // フェードアウト開始
  setTimeout(() => {
    btn.innerHTML = copyIcon;     // フェードアウト後にアイコン戻す
  }, 200);
}, 1200);
```

#### 4.4 チェックマークサイズ調整

**ファイル**: `templates/base.html`

```javascript
const checkIcon = '<svg viewBox="2 4 20 16" ... stroke-width="2.5" ...>';
```

#### 4.5 コピー完了時のボーダー（内側表示）

**ファイル**: `sass/main.scss`

```scss
.codebox-copy.copied {
  border-color: transparent;
  box-shadow: inset 0 0 0 1px #86efac;
}
```
