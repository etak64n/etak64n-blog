# タスクリスト: プロジェクト整合性の修正

## 進捗状況

| 状態 | 記号 |
|------|------|
| 未着手 | ⬜ |
| 進行中 | 🔄 |
| 完了 | ✅ |
| スキップ | ⏭️ |

## タスク一覧

### 1. 事前確認

- [x] 1.1 現状のビルド確認（`zola build`）
- [x] 1.2 Git status の詳細確認

### 2. 設定ファイルの同期

- [x] 2.1 config.toml の設定更新（Zola 0.22 互換）
- [x] 2.2 docs/architecture.md に設定例を追加

### 3. Git ワーキングツリーの整理

- [x] 3.1 不要ファイルの確認（.DS_Store 等）
- [x] 3.2 .gitignore の更新（必要に応じて）→ 既存設定で対応済み
- [x] 3.3 変更をステージング
- [x] 3.4 コミット作成

### 4. 処理済み画像の整理

- ⏭️ 4.1 使用中の画像を特定 → 今回はスキップ（影響なし）
- ⏭️ 4.2 未使用画像のリスト作成 → 今回はスキップ
- ⏭️ 4.3 未使用画像の削除（確認後）→ 今回はスキップ

### 5. 最終検証

- [x] 5.1 クリーンビルド実行
- [x] 5.2 生成された HTML の確認
- [x] 5.3 Git status がクリーンであることを確認

## 完了条件

- [x] config.toml と docs/architecture.md が同期している
- [x] Git working tree がクリーン
- [x] zola build が成功する
- [x] 全記事が正常にレンダリングされる

## 作業ログ

### 2026-01-15

1. **設定形式の変更発覚**
   - Zola 0.22 では設定形式が変更されていた
   - `highlight_code` → `[markdown.highlighting].enabled`
   - `highlight_theme` → `[markdown.highlighting].theme`
   - `render_math` → フロントマターで個別指定

2. **テーマ名の変更**
   - Zola 0.22 で syntect から Giallo に移行
   - `base16-ocean-dark` → `material-theme-ocean`

3. **コミット履歴**
   - `b0b35b4` refactor: カテゴリベースの記事構造に移行
   - `3efcc19` fix: Zola 0.22 互換の設定に更新

## 備考

- 画像整理は今回スキップ（ビルド成功のため優先度低）
- 必要に応じて別作業として実施可能
