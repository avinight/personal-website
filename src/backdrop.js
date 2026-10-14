// Faint wireframes of the five Platonic solids, nested the way Kepler drew
// them in Mysterium Cosmographicum: a cube around a tetrahedron around a
// dodecahedron around an icosahedron around an octahedron. Each one turns on
// its own axis, in its own direction and at its own speed, behind every page,
// and the whole nest leans toward the mouse.
//
// They are drawn with WebGL on one canvas, so a frame is a single draw call
// and the page itself never changes: the browser has no styles, layout or
// paint to redo, which is what made the old SVG version costly.

// -- SHAPE

const phi = (1 + Math.sqrt(5)) / 2;
const signs2 = [
  [1, 1],
  [1, -1],
  [-1, 1],
  [-1, -1],
];

const cube = signs2.flatMap(([a, b]) => [
  [a, b, 1],
  [a, b, -1],
]);

// Every other corner of the cube.
const tetrahedron = [
  [1, 1, 1],
  [1, -1, -1],
  [-1, 1, -1],
  [-1, -1, 1],
];

const octahedron = [
  [1, 0, 0],
  [-1, 0, 0],
  [0, 1, 0],
  [0, -1, 0],
  [0, 0, 1],
  [0, 0, -1],
];

// (0, ±1, ±φ) and its two rotations.
const icosahedron = signs2.flatMap(([a, b]) => [
  [0, a, b * phi],
  [a, b * phi, 0],
  [b * phi, 0, a],
]);

// The cube's corners plus (0, ±1/φ, ±φ) and its two rotations.
const dodecahedron = cube.concat(
  signs2.flatMap(([a, b]) => [
    [0, a / phi, b * phi],
    [a / phi, b * phi, 0],
    [b * phi, 0, a / phi],
  ]),
);

const distanceSquared = (a, b) => (a[0] - b[0]) ** 2 + (a[1] - b[1]) ** 2 + (a[2] - b[2]) ** 2;

// In a Platonic solid the edges are exactly the pairs of corners that are
// closest together.
function edgesOf(points) {
  const pairs = [];
  points.forEach((a, i) => points.forEach((b, j) => j > i && pairs.push([i, j, distanceSquared(a, b)])));
  const shortest = Math.min(...pairs.map(([, , d]) => d));
  return pairs.filter(([, , d]) => Math.abs(d - shortest) < 0.001).map(([i, j]) => [i, j]);
}

// Scale corners to sit on a sphere of radius 1.
function normalize(points) {
  const radius = Math.max(...points.map((v) => Math.hypot(...v)));
  return points.map((v) => v.map((c) => c / radius));
}

// `size` is a solid's distance from the centre to a corner; `yawSpeed` and
// `pitchSpeed` set how fast, and which way, it turns about the vertical and
// horizontal axes; `tone` picks its colour from the theme.
const solid = (corners, options) => ({ corners: normalize(corners), edges: edgesOf(corners), ...options });

// Outermost first, as Kepler ordered them.
const solids = [
  solid(cube, { size: 1.45, yawSpeed: -0.55, pitchSpeed: 0.3, offset: 0.9, tone: 'primary' }),
  solid(tetrahedron, { size: 1.25, yawSpeed: 0.8, pitchSpeed: -0.45, offset: 2.1, tone: 'accent' }),
  solid(dodecahedron, { size: 1.1, yawSpeed: -0.7, pitchSpeed: 0.55, offset: 0.4, tone: 'primary' }),
  solid(icosahedron, { size: 1, yawSpeed: 1, pitchSpeed: 0.7, offset: 0.35, tone: 'accent' }),
  solid(octahedron, { size: 0.7, yawSpeed: -1.25, pitchSpeed: -0.85, offset: 1.3, tone: 'primary' }),
];

// -- LOOK

// The nest spans 2.5 units across the longer side of the screen, so it
// always fills it.
const VIEW = 2.5;
const LINE_WIDTH = 1.25; // CSS pixels
const DOT_RADIUS = 0.046; // in the nest's units
const DOT_SIDES = 32;

// Edges and corners further back are fainter.
const depthFade = (z) => 0.3 + 0.7 * Math.min(1, Math.max(0, (z + 1) / 2));

// -- MOTION

// How the nest is turned: `angle` grows with time, and `tilt` eases toward
// `target`, which follows the mouse.
const motion = { angle: 0.6, tilt: [0, 0], target: [0, 0] };

function step(delta) {
  const dt = Math.min(delta, 50);
  const follow = 1 - Math.exp(-dt / 450);
  motion.angle += dt * 0.00012;
  motion.tilt[0] += (motion.target[0] - motion.tilt[0]) * follow;
  motion.tilt[1] += (motion.target[1] - motion.tilt[1]) * follow;
}

// -- GEOMETRY

// Each vertex is x, y in device pixels, then a premultiplied colour.
const FLOATS = 6;
const vertexCount = solids.reduce((n, s) => n + s.edges.length * 6 + s.corners.length * DOT_SIDES * 3, 0);
const vertices = new Float32Array(vertexCount * FLOATS);

const circle = Array.from({ length: DOT_SIDES + 1 }, (_, i) => {
  const t = (i / DOT_SIDES) * 2 * Math.PI;
  return [Math.cos(t), Math.sin(t)];
});

// Fill `vertices` with this frame's triangles: every edge as a thin quad,
// then every corner as a small disc, solid by solid, outermost first.
function build(width, height, dpr, colours) {
  const scale = (Math.max(width, height) / VIEW) * dpr;
  const cx = (width * dpr) / 2;
  const cy = (height * dpr) / 2;
  const halfLine = (LINE_WIDTH * dpr) / 2;
  const dot = DOT_RADIUS * scale;
  const [tx, ty] = motion.tilt;
  let k = 0;

  const put = (x, y, [r, g, b], a) => {
    vertices[k++] = x;
    vertices[k++] = y;
    vertices[k++] = r * a;
    vertices[k++] = g * a;
    vertices[k++] = b * a;
    vertices[k++] = a;
  };

  for (const shape of solids) {
    const colour = colours[shape.tone];
    const yaw = motion.angle * shape.yawSpeed + shape.offset + tx * 0.45;
    const pitch = motion.angle * shape.pitchSpeed + shape.offset + ty * 0.35;
    const cosYaw = Math.cos(yaw);
    const sinYaw = Math.sin(yaw);
    const cosPitch = Math.cos(pitch);
    const sinPitch = Math.sin(pitch);

    // Turn each corner, then project it with a little perspective. `z`
    // points at the viewer and is relative to the solid's size.
    const points = shape.corners.map(([x, y, z]) => {
      const x1 = x * cosYaw + z * sinYaw;
      const z1 = z * cosYaw - x * sinYaw;
      const y2 = y * cosPitch - z1 * sinPitch;
      const z2 = y * sinPitch + z1 * cosPitch;
      const perspective = (4 / (4 - z2 * shape.size)) * shape.size * scale;
      return [cx + x1 * perspective, cy + y2 * perspective, z2];
    });

    for (const [i, j] of shape.edges) {
      const [ax, ay, az] = points[i];
      const [bx, by, bz] = points[j];
      const length = Math.hypot(bx - ax, by - ay) || 1;
      const nx = (-(by - ay) / length) * halfLine;
      const ny = ((bx - ax) / length) * halfLine;
      const a = depthFade((az + bz) / 2);
      put(ax + nx, ay + ny, colour, a);
      put(ax - nx, ay - ny, colour, a);
      put(bx + nx, by + ny, colour, a);
      put(bx + nx, by + ny, colour, a);
      put(ax - nx, ay - ny, colour, a);
      put(bx - nx, by - ny, colour, a);
    }

    for (const [x, y] of points) {
      for (let s = 0; s < DOT_SIDES; s++) {
        put(x, y, colour, 1);
        put(x + circle[s][0] * dot, y + circle[s][1] * dot, colour, 1);
        put(x + circle[s + 1][0] * dot, y + circle[s + 1][1] * dot, colour, 1);
      }
    }
  }
}

// -- DRAWING

const VERTEX_SHADER = `
attribute vec2 position;
attribute vec4 colour;
uniform vec2 size;
varying vec4 v_colour;
void main() {
  gl_Position = vec4(position.x / size.x * 2.0 - 1.0, 1.0 - position.y / size.y * 2.0, 0.0, 1.0);
  v_colour = colour;
}`;

const FRAGMENT_SHADER = `
precision mediump float;
varying vec4 v_colour;
void main() {
  gl_FragColor = v_colour;
}`;

function compile(gl, type, source) {
  const shader = gl.createShader(type);
  gl.shaderSource(shader, source);
  gl.compileShader(shader);
  return shader;
}

function setUp(gl) {
  const program = gl.createProgram();
  gl.attachShader(program, compile(gl, gl.VERTEX_SHADER, VERTEX_SHADER));
  gl.attachShader(program, compile(gl, gl.FRAGMENT_SHADER, FRAGMENT_SHADER));
  gl.linkProgram(program);
  if (!gl.getProgramParameter(program, gl.LINK_STATUS)) return null;
  gl.useProgram(program);

  gl.bindBuffer(gl.ARRAY_BUFFER, gl.createBuffer());
  gl.bufferData(gl.ARRAY_BUFFER, vertices.byteLength, gl.DYNAMIC_DRAW);
  const stride = FLOATS * 4;
  const position = gl.getAttribLocation(program, 'position');
  const colour = gl.getAttribLocation(program, 'colour');
  gl.enableVertexAttribArray(position);
  gl.vertexAttribPointer(position, 2, gl.FLOAT, false, stride, 0);
  gl.enableVertexAttribArray(colour);
  gl.vertexAttribPointer(colour, 4, gl.FLOAT, false, stride, 8);

  gl.enable(gl.BLEND);
  gl.blendFunc(gl.ONE, gl.ONE_MINUS_SRC_ALPHA);
  gl.clearColor(0, 0, 0, 0);
  return { size: gl.getUniformLocation(program, 'size') };
}

// "#c0623a" -> [0.75, 0.38, 0.23]
function parseColour(value, fallback) {
  const hex = value.trim().match(/^#([0-9a-f]{6})$/i);
  if (!hex) return fallback;
  const n = parseInt(hex[1], 16);
  return [(n >> 16) / 255, ((n >> 8) & 255) / 255, (n & 255) / 255];
}

const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');

// <wire-backdrop> fills itself with a canvas and keeps the nest turning
// for as long as it is on the page.
customElements.define(
  'wire-backdrop',
  class extends HTMLElement {
    connectedCallback() {
      this.canvas = document.createElement('canvas');
      this.canvas.style.cssText = 'display:block;width:100%;height:100%';
      this.appendChild(this.canvas);

      this.gl = this.canvas.getContext('webgl', { alpha: true, antialias: true, depth: false, stencil: false });
      if (!this.gl) return;
      this.uniforms = setUp(this.gl);
      if (!this.uniforms) return;

      this.readColours();
      // The theme switches by toggling a class on <html>.
      this.themeObserver = new MutationObserver(() => {
        this.readColours();
        this.draw();
      });
      this.themeObserver.observe(document.documentElement, { attributes: true, attributeFilter: ['class'] });

      this.onMouseMove = (event) => {
        motion.target = [(event.clientX / window.innerWidth) * 2 - 1, (event.clientY / window.innerHeight) * 2 - 1];
      };
      this.onResize = () => this.draw();
      this.onMotionChange = () => this.start();
      window.addEventListener('mousemove', this.onMouseMove, { passive: true });
      window.addEventListener('resize', this.onResize);
      reducedMotion.addEventListener('change', this.onMotionChange);

      this.canvas.addEventListener('webglcontextlost', (event) => {
        event.preventDefault();
        this.stop();
      });
      this.canvas.addEventListener('webglcontextrestored', () => {
        this.uniforms = setUp(this.gl);
        if (this.uniforms) this.start();
      });

      this.start();
    }

    disconnectedCallback() {
      this.stop();
      this.themeObserver?.disconnect();
      window.removeEventListener('mousemove', this.onMouseMove);
      window.removeEventListener('resize', this.onResize);
      reducedMotion.removeEventListener('change', this.onMotionChange);
    }

    // With reduced motion the nest is drawn once and stays still.
    start() {
      this.stop();
      this.draw();
      if (reducedMotion.matches) return;
      let last = performance.now();
      const frame = (now) => {
        step(now - last);
        last = now;
        this.draw();
        this.raf = requestAnimationFrame(frame);
      };
      this.raf = requestAnimationFrame(frame);
    }

    stop() {
      cancelAnimationFrame(this.raf);
    }

    readColours() {
      const style = getComputedStyle(document.documentElement);
      this.colours = {
        primary: parseColour(style.getPropertyValue('--primary'), [0.9, 0.54, 0.36]),
        accent: parseColour(style.getPropertyValue('--accent'), [0.5, 0.78, 0.79]),
      };
    }

    draw() {
      const gl = this.gl;
      if (!gl || !this.uniforms || gl.isContextLost()) return;
      const dpr = Math.min(window.devicePixelRatio || 1, 2);
      const width = this.clientWidth;
      const height = this.clientHeight;
      if (!width || !height) return;
      const w = Math.round(width * dpr);
      const h = Math.round(height * dpr);
      if (this.canvas.width !== w || this.canvas.height !== h) {
        this.canvas.width = w;
        this.canvas.height = h;
      }

      build(width, height, dpr, this.colours);
      gl.viewport(0, 0, w, h);
      gl.uniform2f(this.uniforms.size, w, h);
      gl.clear(gl.COLOR_BUFFER_BIT);
      gl.bufferSubData(gl.ARRAY_BUFFER, 0, vertices);
      gl.drawArrays(gl.TRIANGLES, 0, vertexCount);
    }
  },
);
