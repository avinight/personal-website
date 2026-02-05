export interface TechStack {
  name: string;
  iconName: string;
}

export interface Experience {
  role: string;
  org: string;
  location: string; // Added
  dates: string;
  summary: string;
  highlights: string[]; // Added
  tech: TechStack[]; // Added
}

// Wrapped the object in [ ] because the type is Experience[]
export const experiences: Experience[] = [
  {
    role: 'Student Researcher',
    org: 'University of Toronto',
    location: 'Toronto, ON',
    dates: 'January 2026 - Present',
    summary: 'Applying the winding number optimization to build an inside-outside indicator function for a Gaussian splat under supervision of Prof. David Levin.',
    highlights: [],
    tech: [
      { name: 'Python', iconName: 'simple-icons:python' }
    ]
  },
  {
    role: 'Software Developer Intern',
    org: 'Knowlecy Technologies Inc.',
    location: 'Vancouver, BC (Remote)',
    dates: 'January 2025 - May 2025',
    summary: 'Built core features in a <strong>retrieval augmented generation (RAG)</strong> chat application using <strong>React</strong> and <strong>Neo4j</strong>',
    highlights: [
      "Eliminated <strong>10+</strong> critical rendering bottlenecks, reducing UI latency and improving application stability.",
      "Enabled <strong>persistent state management</strong> functionality, enhancing user navigation and live feedback loops."
    ],
    tech: [
      { name: 'React', iconName: 'simple-icons:react' },
      { name: 'TypeScript', iconName: 'simple-icons:typescript' },
      { name: 'Neo4j', iconName: 'simple-icons:neo4j' }
    ]
  }
];
