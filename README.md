# Frederick Meneses — personal website

Built with [Elm](https://elm-lang.org) and [Vite](https://vite.dev), hosted on Cloudflare Pages.

## Commands

| Command           | What it does                                        |
| ----------------- | --------------------------------------------------- |
| `npm install`     | Install dependencies (also fetches the Elm compiler) |
| `npm run dev`     | Start a dev server at `localhost:5173`               |
| `npm run build`   | Build the site into `dist/`                         |
| `npm run preview` | Serve the built site locally                        |
| `npm run icons`   | Export any newly used icons to `public/icons/`      |

The visitor counter calls the Cloudflare Pages function in `functions/api/visitors.js`,
so it only shows a number when the site runs on Cloudflare (or `wrangler pages dev dist`).

## Where things live

- `src/Data/` — bio, experience, education and projects. Edit these to change the content.
  In descriptions, `*text*` is bold and `$tex$` is math.
- `src/Page/` — one module per page; `src/Main.elm` holds routing, the header and the footer.
- `src/Logo.elm` — the animated logo. Each picture is drawn as text out of `█ ◤ ◥ ◢ ◣` cells,
  so adding a new one is a matter of drawing it.
- `content/blog/*.md` — blog posts. Markdown and math are rendered at build time.
  Posts with `draft: true` in their front matter stay hidden.
- `src/styles/` — CSS, one file per page or component.

## Cloudflare Pages settings

- Build command: `npm run build`
- Build output directory: `dist`
- Environment variable: `COUNTERAPI_KEY` (used by the visitor counter function)
