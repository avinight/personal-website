# Frederick Meneses — personal website

My personal site, written in [Elm](https://elm-lang.org), built with [Vite](https://vite.dev)
and hosted on Cloudflare Pages.

- **Home** — a typed-out greeting, an interactive logo of terracotta and teal shards that fly
  between pictures (fried rice, a mountain, a dumbbell, a music note, a matcha mug) and scatter
  away from your cursor, plus my tech stack and languages.
- **About** — experience and education on a timeline, and where to find me online.
- **Projects** — project cards with tags, demo and source links, and inline math.
- **Blog** — Markdown posts with KaTeX math, rendered at build time.

Behind every page the five Platonic solids, nested the way Kepler drew them, turn slowly as faint
wireframes and lean toward the mouse. The backdrop and the logo are both drawn with
[elm-explorations/webgl](https://package.elm-lang.org/packages/elm-explorations/webgl/latest/). The site
has a light and dark theme, and the animations stay still for visitors who prefer reduced motion.

## Getting started

You need Node 20.19 or newer (`.node-version` pins 22) and [pnpm](https://pnpm.io).

| Command        | What it does                                           |
| -------------- | ------------------------------------------------------ |
| `pnpm install` | Install dependencies, including the Elm compiler        |
| `pnpm dev`     | Start a dev server at `localhost:5173`                  |
| `pnpm build`   | Build the site into `dist/`                            |
| `pnpm preview` | Serve the built site locally                           |
| `pnpm icons`   | Export any newly used icons to `public/icons/`         |

The visitor counter in the footer calls the Cloudflare Pages function in
`functions/api/visitors.js`, so it shows "—" locally and a number on Cloudflare
(or under `wrangler pages dev dist`).

## Editing content

Everything you'd normally change lives in typed Elm data files:

| File                       | What's in it                                        |
| -------------------------- | --------------------------------------------------- |
| `src/Data/Bio.elm`         | Greeting, about text, tech stack, languages, socials |
| `src/Data/Experiences.elm` | Work history on the About page                      |
| `src/Data/Education.elm`   | Education on the About page                         |
| `src/Data/Projects.elm`    | Project cards                                       |
| `content/blog/*.md`        | Blog posts                                          |

In summaries, highlights and project descriptions you can write:

- `*text*` for **bold**
- `$tex$` for math, e.g. `$O(n^2)$`
- `[text](https://example.com)` for a link that opens in a new tab

Icons use [Iconify](https://icon-sets.iconify.design) ids such as `"simple-icons:python"`,
`"lucide:mail"` or `"twemoji:flag-japan"`. After adding a new one, run `pnpm icons`.

Blog posts start with front matter:

```markdown
---
title: "Hello World"
date: 2026-04-22
description: "Introduction"
tags: ["personal", "writing"]
draft: true
---
```

Posts with `draft: true` stay hidden. While there are no published posts, the Blog page shows
"Coming soon".

## Project layout

```text
src/
  Main.elm          routing, header, footer, theme toggle, visitor counter
  Route.elm         URL → page
  Page/             one module per page (Home, About, Projects, Blog, NotFound)
  Data/             site content
  Logo.elm          the shard logo; each picture is drawn as text from █ ◤ ◥ ◢ ◣ cells
  Backdrop.elm      the rotating wireframe background
  Palette.elm       theme colours for the WebGL drawings (mirrors styles/global.css)
  Rich.elm          the *bold*, $math$ and [link](url) markup
  Icon.elm          icon rendering
  main.js           starts Elm, theme storage, KaTeX and blog post elements
  styles/           CSS, one file per page or component
content/blog/       Markdown posts
functions/api/      Cloudflare Pages function for the visitor counter
public/             static files: logos, icons, favicon, background
scripts/            icon export and the build-time blog renderer
```

## Deploying

Cloudflare Pages builds every push. Its settings:

- Build command: `pnpm run build`
- Build output directory: `dist`
- Environment variable: `COUNTERAPI_KEY` (used by the visitor counter function)

GitHub Actions also builds every push (`.github/workflows/build.yml`) and keeps the built site
as a downloadable artifact for 7 days.
