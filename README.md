# etak64n-blog

This blog is built with [Zola](https://www.getzola.org/), a static site generator written in Rust. Templates leverage the [Tera](https://tera.netlify.app/) engine, and the site is deployed via [Cloudflare Pages](https://pages.cloudflare.com/).

## How to run locally
With Zola installed, run the following:

```bash
zola serve
```

Open <http://127.0.0.1:1111> in your browser to preview the site.

## How to deploy to Cloudflare Pages
Cloudflare Pages does not provide Zola out of the box. This repository includes a
small build script that downloads a compatible binary before generating the
site. Configure your Pages project with:

- Build command: `bash scripts/build.sh`
- Output directory: `public`

When linked to the GitHub repository, pushed changes are deployed automatically.
