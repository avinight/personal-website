/// <reference types="astro/client" />

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
