// Writes every icon referenced in the Elm sources (e.g. "simple-icons:python")
// to public/icons/<set>/<name>.svg. Run `npm run icons` after using a new icon.
import { mkdir, readdir, readFile, writeFile } from 'node:fs/promises';
import path from 'node:path';

const SETS = ['simple-icons', 'lucide', 'twemoji'];
const pattern = new RegExp(`"(${SETS.join('|')}):([a-z0-9-]+)"`, 'g');

async function elmFiles(dir) {
  const entries = await readdir(dir, { withFileTypes: true });
  const nested = await Promise.all(
    entries.map((e) => {
      const full = path.join(dir, e.name);
      if (e.isDirectory()) return elmFiles(full);
      return e.name.endsWith('.elm') ? [full] : [];
    }),
  );
  return nested.flat();
}

const wanted = new Set();
for (const file of await elmFiles('src')) {
  for (const [, set, name] of (await readFile(file, 'utf8')).matchAll(pattern)) {
    wanted.add(`${set}:${name}`);
  }
}

const collections = {};
for (const set of SETS) {
  collections[set] = JSON.parse(
    await readFile(`node_modules/@iconify-json/${set}/icons.json`, 'utf8'),
  );
}

for (const id of [...wanted].sort()) {
  const [set, name] = id.split(':');
  const data = collections[set];
  const icon = data.icons[name] ?? data.icons[data.aliases?.[name]?.parent];
  if (!icon) throw new Error(`Unknown icon ${id}`);
  const width = icon.width ?? data.width ?? 16;
  const height = icon.height ?? data.height ?? 16;
  const svg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${width} ${height}">${icon.body}</svg>\n`;
  await mkdir(`public/icons/${set}`, { recursive: true });
  await writeFile(`public/icons/${set}/${name}.svg`, svg);
}

console.log(`Wrote ${wanted.size} icons to public/icons`);
