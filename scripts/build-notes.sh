#!/usr/bin/env bash
# Build the /notes digital garden (Quartz v4 pinned submodule) into dist/notes.
# Config source-of-truth is notes-config/ (parent repo); staged into the submodule
# because Quartz reads quartz.config.ts from its CWD. Content = notes-content/.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
# Ensure the pinned Quartz submodule is present (Cloudflare Pages doesn't always init submodules).
if [ ! -e "$ROOT/quartz/package.json" ]; then
  echo "quartz submodule missing — initializing"; git submodule update --init --recursive
fi
cp "$ROOT/notes-config/quartz.config.ts" "$ROOT/quartz/quartz.config.ts"
cp "$ROOT/notes-config/quartz.layout.ts" "$ROOT/quartz/quartz.layout.ts"
cd "$ROOT/quartz"
npm ci --no-audit --no-fund
node quartz/bootstrap-cli.mjs build -d ../notes-content -o ../dist/notes
echo "built -> dist/notes"
