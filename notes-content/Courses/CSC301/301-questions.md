---
tags:
  - course/csc301
  - computer-science
---

- What will our tech stack look like for Front-end and Back-end?

- What features do we need to implement 
- Like what kind of UI are we looking at , are there more api like litreturesseach api and how do these api work , what kind of algo we looking at

- Are we working directly with their github code and 
	- if so do we get to access the code to see how to integrate the new work with it? 

	- We are supposed use their api and dbs to make our own search engine build on it usings its endpoints

- MVP most importantly

- What is the goal of the project?
- Who are the users?
	- Researchers for academic writing.
- What do they want to achieve?
- What are the user stories for minimum viable product? Are there at least 5?

- What is the technology stack? Specify languages, frameworks, libraries, PaaS products or tools to be used or being considered.
- How will you deploy the application?
	- Docker
- Describe the architecture - what are the high level components or patterns you will use? Diagrams are useful here.
	- 
- Will you be using third party applications or APIs? If so, what are they?

- Why does your product (as described in your answer to Q1) fits the needs of your users?

serves as a backend
- LLM agent
- input parameters
- api knows 

What we're building
Google Front end
Full type search
semantic similarity relevance

online algo

user feedback/pages most users click on
Online updates

front end input query display list of papers

5-12 pages long

page rank -> display exactly where which paragraph which section 
- display of fine-grained 
- LLM generates an aggrated response via user inputs 
- perplexity ai

keywords: learn from scratch i want get the latest result by AI. Rank the result by newest. Type out professors name. Gives list a papers that the prof has been working on.

ask deeper questions and get answer fast. I can use metadata filter to get exactly what kind of papers or authers i want to get answers and llm will give concise and accurate answer.

literature review not familiar with subject, read original text from paper. don't wann to look individual papers it takes too long.
point to what exactly i want to read so that i can know answer to my question while getting 

I am composing an essay. I remember evidence from article, carbon emission will rise 5% end of decade. I dont remember where it came from. Gives exactly what papers that suggest the same kind of figures. Click on metadata and export copy on my essay. Fast way to get evidence for citation.




Tech Stack : 
- Figma, discuss with designers. Our designer will impleemnt design
- Next.js. Frontend/next -> look at 
- FastAPI for restful requests and data validation

Back-end
- Python
- JavaScript/Typescript (more suitable for this project) -> speed is critical. Not recommend C++, very hard to maintain and easy to introduce bugs. Rust is also fast but has learning curve.

DB:
- Neo4j/Cypher -> similar to SQL more intuitive
- We will benefit 
- Supports native/full-text/similarity search
- Llama index for fine-grained search. Built on python. 
	- Search within 1-10 papers. machine learning tools
- Brand new DB to start from scratch. Run tests 
- Download 10000 papers using a script. how robust/quick is search engine. 

S2- 
 isOpenAccess has to be true to get the paper
3. Find grained search is supposed to be supported by openaccess papers only.
 Send request to this link

Data cleaning - nougat
markdown -> tree data structure in BFS manner
hierarchical tree purpose -> trim search space

LLM tricks


1. 1. Relevance
    2. Robustness
    3. Online updates
    
    Front end web page, input query, a list of papers.
    

    
    Query -> A list of papers -> User click on a page -> Display of fined grained position where user should look into
    
    
    LLM generate an aggregated response provided user inputs a sentence for a question
    
    
    How to put the functionality of
    
    1. paper ranking, a list
    2. metadata filtering, a series of buttons or selections or drop down menus
    3. Fined grained sections/subsections/paragraphs the user should look into.
    4. LLM generated reponse
    
    
    Frontend-Next
    

    
    Next.js
    
    Fastapi

    
    Python/Javascript
    
    Neo4j - Graphical Data (Cypher) (edited)
    
    Neo4j -- full text search, similary search
    
    LLamaIndex -- Fined grained search, ie. within papers, at the level of sections/subsections. (edited)
    
    Semantic Scholar -- data vendor, 1000-10000 papers using script into the database (edited)
    
    
    Nougat -- OCR tool, input is a PDF file, output is markdown file (edited)
    
    
    Note: Do other page ranking first. Once you reached the Fine grained search, talk to us! Seek for advice. (edited)
    

Message Meeting Room 1

40 mins