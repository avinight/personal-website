/// <reference types="astro/client" />
/// <reference types="astro/astro-jsx" />

declare module '*.png' {
	const value: {
		src: string;
		width: number;
		height: number;
	};
	export default value;
}

declare module '*.svg' {
	const value: {
		src: string;
		width: number;
		height: number;
	};
	export default value;
}

declare module '*?url' {
	const src: string;
	export default src;
}

declare global {
	namespace JSX {
		interface IntrinsicElements extends astroHTML.JSX.IntrinsicElements {}
	}
}
