import renderMathInElement from 'katex/contrib/auto-render';

const render = (root: HTMLElement | Document = document) => {
  const target = root instanceof Document ? root.body : root;
  if (!target) return;

  renderMathInElement(target, {
    delimiters: [
      { left: '$$', right: '$$', display: true },
      { left: '$', right: '$', display: false }
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
          render(node as HTMLElement);
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
