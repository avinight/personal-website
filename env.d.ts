/// <reference types="astro/client" />
/// <reference types="astro/astro-jsx" />

declare global {
	namespace JSX {
		// Fallback for editors that still don't pick up Astro's JSX types.
		// This avoids "JSX.IntrinsicElements" missing errors in .astro files.
		interface IntrinsicElements extends astroHTML.JSX.IntrinsicElements {
			[key: string]: any;
		}
	}
}

export {};
