import { defineConfig } from 'vite';
import elm from 'vite-plugin-elm';
import blog from './scripts/vite-plugin-blog.js';

// Browsers older than these get CSS nesting flattened by Lightning CSS.
const v = (major) => major << 16;

export default defineConfig({
  plugins: [elm(), blog()],
  css: {
    transformer: 'lightningcss',
    lightningcss: {
      targets: { chrome: v(100), edge: v(100), firefox: v(100), safari: v(15) },
    },
  },
  build: {
    cssMinify: 'lightningcss',
  },
});
