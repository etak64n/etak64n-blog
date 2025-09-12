# etak64n-blog

Blog built with Zola + Tera and deployed to Cloudflare Pages via GitHub Actions.

Highlights
- Grid cards for Latest/Indexes (large thumbnail + title + date)
- Sticky Table of Contents (ToC) on the left of article pages
- Hero image support (fallback placeholder when not provided)
- Tags/Categories (taxonomies), related posts generated at build time by tag match
- Feeds disabled by default (can be enabled later)

## Requirements
- Zola — install: https://www.getzola.org/documentation/getting-started/installation/

## Local development
- Start dev server: `zola serve` → http://127.0.0.1:1111/
- Build for production: `zola build` → output in `public/`

## Project structure (excerpt)
- `content/articles/` — posts section (year/month/post)
- `templates/` — Tera templates
  - `templates/base.html` — shared layout
  - `templates/index.html` — Home (latest posts)
  - `templates/articles/list.html` — Articles index
  - `templates/articles/single.html` — Article page
  - `templates/taxonomy_list.html`, `templates/taxonomy_single.html` — Tags/Categories
- `sass/main.scss` — site styles (compiled to `main.css`)
- `static/images/` — images served under `/images/...`

## Writing posts
Add a Markdown file under `content/articles/YYYY/MM/slug.md`.

Front matter example (TOML):
```toml
+++
title = "Title"
date = 2025-09-01
updated = 2025-09-01
draft = false
taxonomies = { tags=["AWS","QuickSight"], categories=["Analytics"] }
[extra]
hero = "/images/your-hero.svg"  # optional; placeholder used if omitted
toc = true                       # enable ToC
+++

Body...
```

Notes
- Place hero images under `static/images/` and reference via `/images/...`.
- The ToC is generated automatically from headings (##, ###, ...).
- Related posts are computed at build time by tag overlap (tweakable in template).

## Taxonomies (Tags/Categories)
- Configured in `config.toml` via `[[taxonomies]]` blocks for `tags` and `categories`.
- Term pages render as a responsive card grid.

## Deployment (Cloudflare Pages)
- Build command: `zola build -u "${CF_PAGES_URL:-https://blog.etak64n.dev/}"`
  - Output directory: `public`
  - Direct upload via Wrangler: `wrangler pages deploy public`

Notes
- Feeds are currently disabled (`generate_feeds = false`). Turn on and add a header link if you need them.
- `wrangler.toml` is for Pages Direct Upload/Workers. If you only use Pages (GitHub integration), it may remain unused.
- If a preview shows old styles, view page source and check the `main.css` URL domain. It should be the preview domain when using the build command above.
