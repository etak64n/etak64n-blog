# 設計

## 実装アプローチ
JavaScriptによるDOM操作でURLを自動リンク化する。

## 変更するコンポーネント
- `templates/base.html` - DOMContentLoadedイベント内にスクリプトを追加

## 処理フロー

```
1. DOMContentLoaded発火
2. .content要素を取得
3. テキストノードを再帰的に走査
4. URLパターンにマッチするテキストを検出
5. 除外要素（a, pre, code, .codebox）内かチェック
6. マッチしたURLを<a>タグに置換
```

## URLパターン
```javascript
/https?:\/\/[^\s<>"')\]]+/g
```

## 除外対象
- `<a>` - 既存のリンク
- `<pre>` - コードブロック
- `<code>` - インラインコード
- `.codebox` - カスタムコードボックス

## リンク属性
- `target="_blank"` - 新しいタブで開く
- `rel="noopener noreferrer"` - セキュリティ対策
