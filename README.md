# etak64n-blog

## How to run locally
With Zola installed, run the following:

```bash
zola serve
```

Open <http://127.0.0.1:1111> in your browser to preview the site.

## How to deploy to Cloudflare Pages
Configure Cloudflare Pages with:

- Build command: `zola build`
- Output directory: `public`

When linked to the GitHub repository, pushed changes are deployed automatically.
