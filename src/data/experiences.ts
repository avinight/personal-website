export interface TechStack {
  name: string;
  iconName: string;
}

export interface Experience {
  role: string;
  org: string;
  location: string;
  dates: string;
  summary: string;
  highlights: string[];
  tech: TechStack[];
  logoUrl?: string;
  logoIconName?: string;
}

// Wrapped the object in [ ] because the type is Experience[]
export const experiences: Experience[] = [
  {
    role: 'Software Engineer Intern',
    org: 'TD Bank',
    location: 'Toronto, ON',
    dates: 'May 2026 - Present',
    summary: 'Backend/DevOps',
    highlights: [],
    tech: [
      { name: 'Python', iconName: 'simple-icons:python' }
    ],
    logoUrl: '/logos/Toronto-Dominion_Bank_logo.svg'
  },
  {
    role: 'Student Researcher',
    org: 'University of Toronto',
    location: 'Toronto, ON',
    dates: 'January 2026 - April 2026',
    summary: 'Applying the winding number optimization to build an inside-outside indicator function for a Gaussian splat under supervision of Prof. David Levin.',
    highlights: [],
    tech: [
      { name: 'Python', iconName: 'simple-icons:python' }
    ],
    logoUrl: '/logos/Utoronto_coa.svg'
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
    ],
    logoUrl: '/logos/Knowlecy_logo.svg'
  }
];
