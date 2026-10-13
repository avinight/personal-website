import katex from 'katex';
import 'katex/dist/katex.min.css';
import posts from 'virtual:blog-posts';
import { Elm } from './Main.elm';
import './styles/global.css';
import './styles/header.css';
import './styles/footer.css';
import './styles/logo.css';
import './styles/home.css';
import './styles/about.css';
import './styles/projects.css';
import './styles/blog.css';
import './styles/post.css';

// <katex-math tex="..."> renders inline math written as $...$ in the data files.
customElements.define(
  'katex-math',
  class extends HTMLElement {
    static observedAttributes = ['tex'];

    connectedCallback() {
      this.render();
    }

    attributeChangedCallback() {
      this.render();
    }

    render() {
      const tex = this.getAttribute('tex');
      if (tex !== null) katex.render(tex, this, { throwOnError: false });
    }
  },
);

// <post-body> shows a post's HTML, rendered from Markdown at build time.
customElements.define(
  'post-body',
  class extends HTMLElement {
    set html(value) {
      this.innerHTML = value;
    }
  },
);

function storage(key, value) {
  try {
    if (value === undefined) return localStorage.getItem(key);
    localStorage.setItem(key, value);
  } catch {
    return null;
  }
}

function applyTheme(theme) {
  document.documentElement.classList.toggle('dark', theme === 'dark');
}

const theme = storage('theme') ?? 'dark';
applyTheme(theme);

const newVisitor = !storage('fm-visited');
if (newVisitor) storage('fm-visited', '1');

const app = Elm.Main.init({
  flags: {
    theme,
    year: new Date().getFullYear(),
    newVisitor,
    reducedMotion: window.matchMedia('(prefers-reduced-motion: reduce)').matches,
    posts,
  },
});

app.ports.saveTheme.subscribe((next) => {
  applyTheme(next);
  storage('theme', next);
});
