# etak64n-blog

This blog is built with [Zola](https://www.getzola.org/), a static site generator written in Rust. Templates leverage the [Tera](https://tera.netlify.app/) engine, and the site is deployed via [Cloudflare Pages](https://pages.cloudflare.com/).

## How to run locally
With Zola installed, run the following:

```bash
zola serve
```

Open <http://127.0.0.1:1111> in your browser to preview the site.

## How to deploy to Cloudflare Pages
Cloudflare Pages can install Zola automatically when the `ZOLA_VERSION`
environment variable is set. Configure your Pages project with:

- Environment variable: `ZOLA_VERSION`
- Build command: `zola build`
- Output directory: `public`

When linked to the GitHub repository, pushed changes are deployed automatically.
