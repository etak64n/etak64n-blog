# Design: コードブロックのコピーボタン改善

## 変更対象ファイル

| ファイル | 変更内容 |
|---------|---------|
| `sass/main.scss` | コピーボタンのスタイル変更 |
| `templates/base.html` | コピーボタンのJS実装変更 |

## 実装アプローチ

### CSS変更 (`sass/main.scss`)

#### ボタンの非表示/表示制御
```scss
.codebox-copy {
  opacity: 0;
  visibility: hidden;
  // トランジションは削除（消える時のチラつき防止）
}

// ホバー時のみ表示（表示時のみトランジション適用）
.codebox-pre:hover .codebox-copy {
  opacity: 0.9;
  visibility: visible;
  transition: opacity 150ms ease, visibility 150ms ease;
}

// コピー完了時は常に表示
.codebox-copy.copied {
  opacity: 1;
  visibility: visible;
}
```

#### ボタンのレイアウト
- `display: flex` でアイコンを中央配置
- `padding: 6px` でアイコン周りの余白確保
- SVGアイコンサイズ: `16px x 16px`

### JavaScript変更 (`templates/base.html`)

#### SVGアイコンの定義
```javascript
const copyIcon = '<svg viewBox="0 0 24 24" ...>/* クリップボードアイコン */</svg>';
const checkIcon = '<svg viewBox="0 0 24 24" ...>/* チェックマークアイコン */</svg>';
```

#### コピー処理のフロー
1. ボタンクリック時にテキストをクリップボードにコピー
2. アイコンをチェックマークに変更
3. `copied` クラスを追加（CSSで常時表示）
4. 1.2秒後に `copied` クラスを削除し、アイコンを元に戻す
5. マウスがホバーしていなければCSSにより自動的に非表示

## アイコンデザイン

### コピーアイコン（クリップボード）
- Feather Icons スタイル
- stroke-width: 2
- 2つの重なった四角形で表現

### 完了アイコン（チェックマーク）
- Feather Icons スタイル
- stroke-width: 2
- シンプルなチェックマーク

## ダークモード対応
既存のダークモードスタイルをそのまま活用：
- `.codebox.dark .codebox-copy` - ダークモード時の通常状態
- `.codebox.dark .codebox-copy.copied` - ダークモード時の完了状態
