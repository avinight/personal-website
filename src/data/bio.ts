export interface Social {
  platform: string;
  url: string;
  iconName: string;
  username?: string;
}

export const bio = {
  greeting: "Hi, I'm Frederick!",

  aboutIntro: [
    "I am obsessed with health, technology, and learning. In my free time, I love going to the gym, climbing, playing instruments, and watching politics!",
    "Below are some places I've worked and studied.",
  ],

  about: [
    "I am a software engineer, mathematics enthusiast, and lifelong learner. I am passionate about building efficient and scalable systems that solve real-world problems.",
    "I have research interests in data structure optimization, high performance computing, and computer graphics.",
    "When I am not programming, I enjoy exploring the world through learning new languages, reading books, rock climbing, and playing piano.",
  ],

  anime: {
    anilist: { username: "AviNight", url: "https://anilist.co/user/AviNight/" },
    mal:     { username: "AviNight", url: "https://myanimelist.net/profile/AviNight" },
  },

  techStack: {
    heading: "Tech Stack",
    languages: [
      { name: "Python",     iconName: "simple-icons:python"      },
      { name: "Java",       iconName: "simple-icons:oracle"      },
      { name: "C++",        iconName: "simple-icons:cplusplus"   },
      { name: "C",          iconName: "simple-icons:c"           },
      { name: "Zig",        iconName: "simple-icons:zig"         },
      { name: "SQL",        iconName: "simple-icons:mysql"       },
      { name: "JavaScript", iconName: "simple-icons:javascript"  },
      { name: "TypeScript", iconName: "simple-icons:typescript"  },
      { name: "Haskell",    iconName: "simple-icons:haskell"     },
    ],
  },

  languages: {
    heading: "Languages",
    languages: [
      { name: "English", iconName: "twemoji:flag-united-states" },
      { name: "French",  iconName: "twemoji:flag-france"        },
      { name: "Tagalog", iconName: "twemoji:flag-philippines"   },
      { name: "Japanese", iconName: "twemoji:flag-japan"        },
    ],
  },

  socials: [
    { platform: "Linktree", url: "https://linktr.ee/_.friedrice",                    iconName: "simple-icons:linktree", username: "_.friedrice"  },
    { platform: "Devpost",  url: "https://devpost.com/avinight",                      iconName: "simple-icons:devpost",  username: "avinight"     },
    { platform: "Hevy",     url: "https://hevy.com/user/friedricemm",                 iconName: "lucide:dumbbell",       username: "friedricemm"  },
  ] as Social[],
};
