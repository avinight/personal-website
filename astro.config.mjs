// @ts-check
import { defineConfig } from 'astro/config';
import icon from 'astro-icon';
import rehypeKatex from 'rehype-katex';
import remarkMath from 'remark-math';

// https://astro.build/config
export default defineConfig({
	integrations: [icon()],
	output: 'static',
	markdown: {
		remarkPlugins: [remarkMath],
		rehypePlugins: [rehypeKatex]
	}
});