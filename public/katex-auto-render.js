import renderMathInElement from 'https://cdn.jsdelivr.net/npm/katex@0.16.45/dist/contrib/auto-render.mjs';

const render = (root = document) => {
  const target = root instanceof Document ? root.body : root;
  if (!target) return;

  renderMathInElement(target, {
    delimiters: [
      { left: '$$', right: '$$', display: true },
      { left: '$', right: '$', display: false },
      { left: '\\(', right: '\\)', display: false },
      { left: '\\[', right: '\\]', display: true }
    ],
    ignoredTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code'],
    throwOnError: false
  });
};

const onReady = () => {
  render(document);

  const container = document.getElementById('page-content') ?? document.body;
  const observer = new MutationObserver(mutations => {
    for (const mutation of mutations) {
      mutation.addedNodes.forEach(node => {
        if (node.nodeType === Node.ELEMENT_NODE) {
          render(node);
        }
      });
    }
  });

  observer.observe(container, { childList: true, subtree: true });
};

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', onReady);
} else {
  onReady();
}
