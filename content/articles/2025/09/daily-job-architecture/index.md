+++
title = "Daily Job のアーキテクチャを比較してみました"
date = 2025-09-15
updated = 2025-09-15
draft = false
taxonomies = { tags=["Cloudflare Workers"], categories=["Cloudflare"] }
[extra]
author = "etak64n"
hero = "/images/hero/placeholder.svg"
toc = true
+++

## Daily Job のアーキテクチャを比較してみました

| 候補                                   | 実現方法                                              |     手軽さ |          目安料金（1日1回/月） | どんな人におすすめか？                     | 注意点                             |
| ------------------------------------ | ------------------------------------------------- | ------: | --------------------: | ------------------------------- | ------------------------------- |
| GitHub Actions（スケジュール）               | `.github/workflows` に `on: schedule`（cron/UTC）を書く |   ★★★★★ |         **\$0**（無料枠内） | GitHubでコード管理していて、軽〜中量の定期処理を回したい | ランナー時間に上限／厳密な秒単位は不可／ジョブはUTC基準   |
| GitLab CI/CD（スケジュール）                 | GUIまたは `.gitlab-ci.yml` のスケジュール設定                 |    ★★★★ |         **\$0**（無料枠内） | GitLab運用中のチーム                   | 無料分のCI分数が少なめ／自前Runnerで運用負荷増     |
| Bitbucket Pipelines（スケジュール）          | リポジトリ設定から日次ジョブを作成                                 |     ★★★ |         **\$0**（無料枠内） | Bitbucketユーザーで簡易な日次処理           | 無料分が少ない／実行時間・リソースが限られる          |
| Cloudflare Workers（Cron Triggers）    | Workerに `scheduled` ハンドラ＋Cron                     |     ★★★ |           **\$0〜\$5** | API連携・通知などの小さな日次タスク             | FreeはCPU/時間の制限が厳しめ／重い処理は有料プラン推奨 |
| Vercel Cron Jobs                     | ダッシュボード or `vercel.json` でCron → サーバレス関数起動        |    ★★★★ |       **\$0**（Hobby内） | 既にVercelでサイト/関数を運用中             | 実行時刻に揺れ（ウィンドウ）あり／コールドスタート       |
| Netlify Scheduled Functions          | Functionsにスケジュール指定（UTC）                           |     ★★★ |         **\$0**（無料枠内） | Netlify利用者の軽い日次処理               | 実行時間が短め／長時間バッチ不向き               |
| AWS Lambda + EventBridge             | EventBridgeのスケジュールでLambda実行                       |    ★★★★ |         **\$0**（無料枠内） | 信頼性・監視・厳密な時刻を重視                 | IAM設定やVPC周りの知識が必要／コールドスタート      |
| GCP Cloud Run Jobs + Cloud Scheduler | Jobを作成しSchedulerで毎日起動                             |    ★★★★ |         **\$0**（無料枠内） | コンテナで短時間のバッチを動かしたい              | 起動遅延があり得る／リージョン整合に注意            |
| Azure Functions（Timer Trigger）       | Timerトリガー（NCRONTAB）で日次実行                          |    ★★★★ |         **\$0**（無料枠内） | Azure中心の環境                      | コールドスタート／タイムゾーン設定の扱いに注意         |
| Koyeb（常駐＋擬似Cron）                     | サービス内で `cron`/`supercronic` 等を常駐実行                |     ★★★ |              **\$0〜** | 既にKoyebで常駐コンテナがある               | 常時稼働コストがかかる／再起動時の再スケジュール対策      |
| 自宅サーバ／VPS（cron/systemd）              | Linuxの `cron` / `systemd-timer` で実行               | ★★〜★★★★ | **\$0〜\$4**（VPS最安クラス） | 最安で自由度重視・自分で管理できる人              | 監視/バックアップ/復旧が自前／セキュリティ・電源/回線リスク |
