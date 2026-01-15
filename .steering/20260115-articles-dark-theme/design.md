# 設計

## 変更ファイル
- `sass/main.scss` - ダークテーマ用スタイル追加

## 詳細設計

### 1. 記事カードのダークテーマ対応

```scss
:root[data-theme='dark'] .post-list li {
  background: linear-gradient(180deg, #1e293b 0%, #172033 100%);
  border-color: rgba(148, 163, 184, 0.3);
  box-shadow:
    0 2px 4px rgba(2, 6, 23, 0.4),
    0 10px 24px rgba(2, 6, 23, 0.3);
}

:root[data-theme='dark'] .post-list li:hover {
  background: linear-gradient(180deg, #253449 0%, #1e293b 100%);
  box-shadow:
    0 4px 8px rgba(2, 6, 23, 0.5),
    0 16px 32px rgba(2, 6, 23, 0.4);
  border-color: rgba(148, 163, 184, 0.5);
}

:root[data-theme='dark'] .thumb {
  background: rgba(148, 163, 184, 0.1);
  border-color: rgba(148, 163, 184, 0.2);
}
```

### 2. ページネーションのダークテーマ対応

```scss
:root[data-theme='dark'] .pagination a,
:root[data-theme='dark'] .pagination span {
  background: #1e293b;
  border-color: rgba(148, 163, 184, 0.3);
  color: var(--text);
}

:root[data-theme='dark'] .pagination a:hover {
  background: #334155;
  border-color: rgba(96, 165, 250, 0.5);
  color: #93c5fd;
}

:root[data-theme='dark'] .pagination .current {
  background: rgba(59, 130, 246, 0.2);
  border-color: rgba(96, 165, 250, 0.5);
  color: #93c5fd;
}
```
