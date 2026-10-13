// Turns content/blog/*.md into a virtual module of posts with ready-made HTML,
// so Markdown and KaTeX run at build time and Elm only receives finished HTML.
import { readdir, readFile } from 'node:fs/promises';
import path from 'node:path';
import { Marked } from 'marked';
import markedKatex from 'marked-katex-extension';

const ID = 'virtual:blog-posts';
const RESOLVED = '\0' + ID;
const DIR = path.resolve('content/blog');

const marked = new Marked(markedKatex({ throwOnError: false, nonStandard: true }));

// Front matter is a small subset of YAML: `key: value` lines, where a value
// may be a quoted string, a JSON-style array, true/false, or a bare string.
export function parseFrontMatter(source) {
  const match = /^---\r?\n([\s\S]*?)\r?\n---\r?\n?/.exec(source);
  if (!match) return { data: {}, body: source };
  const data = {};
  for (const line of match[1].split(/\r?\n/)) {
    const kv = /^(\w+):\s*(.*)$/.exec(line);
    if (!kv) continue;
    const raw = kv[2].trim();
    let value = raw;
    if (raw === 'true' || raw === 'false') value = raw === 'true';
    else if (/^["[]/.test(raw)) {
      try { value = JSON.parse(raw); } catch { value = raw; }
    }
    data[kv[1]] = value;
  }
  return { data, body: source.slice(match[0].length) };
}

const dateLabel = (iso) =>
  new Date(iso).toLocaleDateString('en-CA', {
    year: 'numeric', month: 'long', day: 'numeric', timeZone: 'UTC',
  });

export async function loadPosts() {
  const files = (await readdir(DIR)).filter((f) => f.endsWith('.md'));
  const posts = await Promise.all(
    files.map(async (file) => {
      const { data, body } = parseFrontMatter(await readFile(path.join(DIR, file), 'utf8'));
      const date = String(data.date ?? '');
      return {
        slug: file.replace(/\.md$/, ''),
        title: String(data.title ?? ''),
        date,
        dateLabel: date ? dateLabel(date) : '',
        description: String(data.description ?? ''),
        tags: Array.isArray(data.tags) ? data.tags.map(String) : [],
        draft: data.draft === true,
        html: marked.parse(body),
      };
    }),
  );
  return posts.sort((a, b) => b.date.localeCompare(a.date));
}

export default function blog() {
  return {
    name: 'blog-posts',
    resolveId(id) {
      if (id === ID) return RESOLVED;
    },
    async load(id) {
      if (id !== RESOLVED) return;
      for (const file of await readdir(DIR)) this.addWatchFile(path.join(DIR, file));
      return `export default ${JSON.stringify(await loadPosts())};`;
    },
    handleHotUpdate({ file, server }) {
      if (!file.startsWith(DIR)) return;
      const mod = server.moduleGraph.getModuleById(RESOLVED);
      if (mod) server.moduleGraph.invalidateModule(mod);
      server.ws.send({ type: 'full-reload' });
    },
  };
}
