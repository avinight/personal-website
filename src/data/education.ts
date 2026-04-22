export interface Education {
  degree: string;
  institution: string;
  location: string;
  dates: string;
  details?: string[];
}

export const education: Education[] = [
  {
    degree: 'Honours Bachelor of Science — Computer Science',
    institution: 'University of Toronto',
    location: 'Toronto, ON',
    dates: '2022 - Present',
    details: [
      'Focus in Computer Systems',
    ],
  },
];
