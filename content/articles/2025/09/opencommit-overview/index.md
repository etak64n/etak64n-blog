+++
title = "AIにコミットメッセージを書かせる「OpenCommit」"
date = 2025-09-16
updated = 2025-09-16
draft = false
taxonomies = { tags=["OpenAI", "ChatGPT"], categories=["OpenAPI"] }
[extra]
author = "etak64n"
hero = "/images/hero/placeholder.svg"
toc = true
+++

## AIにコミットメッセージを書かせる「OpenCommi」

{{ link(url="https://github.com/di-sukharev/opencommit", title="di-sukharev/opencommit") }}

### インストール手順

GitHub に手順が記載されています。

{{ link(url="https://github.com/di-sukharev/opencommit", title="di-sukharev/opencommit") }}

1. npm で opencommit をインストールします
2. OpenAI などから API キーを取得します
3. OpenCommit config にキーを設定します

**npm で opencommit をインストールします**

```sh
(๑>ᴗ<) < npm install -g opencommit
```

**OpenAI などから API キーを取得します**

省略

**OpenCommit config にキーを設定します**

```sh
(๑>ᴗ<) < oco config set OCO_API_KEY=sk-proj-tSp...
┌  COMMAND: config set OCO_API_KEY=sk-proj-tSp...
│
└  ✔ config successfully set
```

### Help

```sh
(๑>ᴗ<) < oco --help                                                      (git)-[main]
opencommit v3.2.10

Auto-generate impressive commits in 1 second. Killing lame commits with AI 🤯🔫

Usage:
  opencommit [flags...]
  opencommit <command>

Commands:
  config            Configure opencommit settings                                     
  hook                                                                                
  commitlint                                                                          

Flags:
  -c, --context <string>        Additional user input context for the commit message  
      --fgm                     Use full GitMoji specification                        
  -h, --help                    Show help                                             
      --version                 Show version                                          
  -y, --yes                     Skip commit confirmation prompt                       
```

### 使い方

1. git add でファイルをステージングに追加します
2. oco

### まとめ
`oco` コマンドにより、自動で commit メッセージを入れてくれるようになりました。