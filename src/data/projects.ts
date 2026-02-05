export interface Project {
  title: string;
  description: string | string[];
  demoUrl?: string;
  sourceUrl?: string;
  tags?: Array<{ name: string; iconName: string }>;
}

// Icon names from Simple Icons (https://icon-sets.iconify.design/simple-icons/)
// Available icons for your tech stack:
// Languages: python, cplusplus, c, zig, mysql (for SQL), oracle (Java), typescript, haskell, r, gnubash
// Frameworks: react, scikitlearn, pandas, postgresql, neo4j
// Tools: git, linux, vim, jira, latex

export const projects: Project[] = [
  {
    title: "Search Engine Project",
    description: [
        "*Led* a *6-person* team for the development of a B2B real-time search engine application with full-text NLP-based query matching and semantic relevance via embedding similarity, using *agile* methodologies.",
        "Implemented user feedback loops (ratings, citations) and *AI-generated* summaries, integrating *React* components with *Neo4j*, resulting in improved data tagging for the *RAG* pipeline.",
        "Scaled to *10,000+* papers and *500+* daily searches, *<1* second query latency with *microservice* architecture, *Neo4j* indexing, and *Docker/AWS* back-end, *Vercel* front-end deployment."
    ],
    demoUrl: "https://www.youtube.com/watch?v=L-2fCBj8h5w&feature=youtu.be",
    sourceUrl: "https://csc301-2024-f.github.io/search-frontend/index.html",
    tags: [
      { name: "React", iconName: "simple-icons:react" },
      { name: "TypeScript", iconName: "simple-icons:typescript" },
      { name: "PostgreSQL", iconName: "simple-icons:postgresql" }
    ]
  },
  {
    title: "Student Response Classifier",
    description: "*Led* a *4-person* team to train Naive Bayes, Random Forest, and Neural Network classifiers using TF-IDF, achieving *95%* validation accuracy using *500* trees.",
    sourceUrl: "https://github.com/David1425/CSC311_project",
    tags: [
      { name: "Python", iconName: "simple-icons:python" },
      { name: "Pandas", iconName: "simple-icons:pandas" },
      { name: "Scikit-learn", iconName: "simple-icons:scikitlearn" }
    ]
  },
  {
    title: "KVStore Database",
    description: "A Tiered Log Structured Merge (LSM) Tree implementation in Zig for write optimized workloads using a *ZipTree/SkipList* Memtable. Inspired by *Cassandra*, *Tigerbeetle*, and *RocksDB*.",
    tags: [
      { name: "Zig", iconName: "simple-icons:zig" },
    ]
  },
  {
    title: "Archive Management Tool",
    description: "A custom archive management tool (“kar”) from scratch, capable of creating and extracting archives with recursive directory support, modeled after UNIX tar utility. Implemented efficient memory management with Valgrind to eliminate leaks, handling multiple linked list directory data structures.",
    sourceUrl: "https://github.com/avinight/kar-archive-tool",
    tags: [
      { name: "C", iconName: "simple-icons:c" },
      { name: "Bash", iconName: "simple-icons:gnubash" }
    ]
  },
  {
    title: "FoodBar",
    description: [
        "*Co-led* a *7-person* team to develop a social media app for cooking enthusiasts, enabling users to post, search, and share recipes with features like ingredient filtering, serving size adjustment, and recipe saving in *Java*.",
        "Followed *SOLID* design principles and adhered to *Clean Architecture*. Implemented user-driven functionalities, including user registration, interactive recipe reviews, and dynamic content filtering by cuisine or popularity."
    ],
    sourceUrl: "github.com/avinight/Foodbar",
    tags: [
      { name: "Java", iconName: "simple-icons:oracle" },
      { name: "Mongo", iconName: "simple-icons:mongodb" },
      { name: "Gradle", iconName: "simple-icons:gradle" },
      { name: "Android Studio", iconName: "simple-icons:androidstudio" }
    ]
  },
  {
    title: "MIPS Breakout Assembly",
    description: "Used *MIPS Assembly* to implement a working version of the game Breakout.",
    sourceUrl: "https://github.com/avinight/breakout",
    tags: [
      { name: "Assembly", iconName: "simple-icons:gnu" }
    ]
  },
  {
    title: "Haskell Interpreter",
    description: "Implemented a Haskell interpreter to understand functional programming.",
    sourceUrl: "",
    tags: [
      { name: "Haskell", iconName: "simple-icons:haskell" }
    ]
  }
];
