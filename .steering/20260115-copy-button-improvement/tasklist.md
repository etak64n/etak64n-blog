# Tasklist: コードブロックのコピーボタン改善

## 完了したタスク

- [x] 現在のコピーボタン実装を調査
  - `templates/base.html` - JavaScript実装
  - `sass/main.scss` - スタイル定義

- [x] CSSでホバー時のみ表示する実装
  - `.codebox-copy` のデフォルトを `opacity: 0; visibility: hidden;` に変更
  - `.codebox-pre:hover .codebox-copy` で表示制御

- [x] テキストをSVGアイコンに置き換え
  - クリップボードアイコン（コピー前）
  - チェックマークアイコン（コピー後）

- [x] コピー完了状態の表示時間調整
  - 1.2秒間表示するよう `setTimeout` を調整

- [x] コピー完了中の表示維持
  - `.codebox-copy.copied` に `opacity: 1; visibility: visible;` を追加

- [x] 完了後のチラつき防止
  - ベースの `.codebox-copy` からトランジションを削除
  - ホバー時のみトランジションを適用

- [x] 開発サーバーで動作確認

## 備考
- ダークモードのスタイルは既存のものをそのまま活用
- アイコンはFeather Iconsスタイルを採用
