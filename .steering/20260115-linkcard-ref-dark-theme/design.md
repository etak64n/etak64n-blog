# 設計

## 変更ファイル
- `sass/main.scss` - ダークテーマ用スタイル
- `templates/base.html` - 参考文献ポップアップの当たり判定

## 詳細設計

### 1. リンクカードのダークテーマ改善

```scss
:root[data-theme='dark'] .content figure.link-card {
  background: linear-gradient(180deg, #1e293b 0%, #172033 100%);
  border-color: rgba(96, 165, 250, 0.3);
  box-shadow: 0 2px 8px rgba(2,6,23,0.4), 0 10px 24px rgba(2,6,23,0.3);
}
:root[data-theme='dark'] .content figure.link-card:hover {
  background: linear-gradient(180deg, #253449 0%, #1e293b 100%);
  border-color: rgba(96, 165, 250, 0.5);
  box-shadow: 0 4px 12px rgba(2,6,23,0.5), 0 16px 32px rgba(2,6,23,0.4);
}
```

### 2. 参考文献リンクのダークテーマ改善

```scss
:root[data-theme='dark'] .ref-trigger {
  border-color: rgba(96, 165, 250, 0.4);
  background: #1e293b;
  color: #93c5fd;
}
:root[data-theme='dark'] .ref-panel {
  background: #1e293b;
  border-color: rgba(96, 165, 250, 0.4);
}
```

### 3. 参考文献ポップアップの当たり判定改善

**変更前:**
- 全体パディング: 16px
- トリガーとパネルを含む矩形全体を当たり判定

**変更後:**
- 全体パディング: 8px
- 右側パディング: 4px
- トリガー、パネル、接続領域を個別にチェック

```javascript
const hoverPadding = 8;
const hoverPaddingRight = 4;

const zoneContains = (x, y) => {
  // トリガー領域
  const inTrigger = ...;
  // パネル領域
  const inPanel = ...;
  // トリガーとパネルの間の接続領域
  const inBridge = ...;
  return inTrigger || inPanel || inBridge;
};
```
