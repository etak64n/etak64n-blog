# etak64n-blog

This blog is built with [Zola](https://www.getzola.org/), a static site generator written in Rust. Templates leverage the [Tera](https://tera.netlify.app/) engine, and the site is deployed via [Cloudflare Pages](https://pages.cloudflare.com/).

## How to run locally
With Zola installed, run the following:

```bash
zola serve
```

Open <http://127.0.0.1:1111> in your browser to preview the site.

## Deployment
The site is built and deployed with GitHub Actions. The workflow runs `zola build`
and publishes the `public` directory to Cloudflare Pages using the
[Cloudflare Pages Action](https://github.com/cloudflare/pages-action).

To enable deployments, configure the following repository secrets:

- `CLOUDFLARE_ACCOUNT_ID`
- `CLOUDFLARE_API_TOKEN`

Pushing to the `main` branch triggers the workflow and updates the site.
