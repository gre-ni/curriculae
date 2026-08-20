## About

This database which I designed serves as a backbone of an app that I would like to build. The app helps adult learners organise their self-directed studies into a clear university-like structure, so that their work is focused and well-scoped.

Technology: PostgreSQL

---

## Entities

### Modules

_Example: 'CS50SQL'_
Module is a scoped class (6-8 weeks of material) belonging to an academic semester, requiring weeks of study.
Each student can select up to 3 modules per semester. By doing so, module will be connected to that semester's foreign key. Modules with NULL semester FK are considered backlogged.

**Types of modules:**

1. Foundational = encourages developing depth and real understanding
2. Project-based = encourages practical application of learned material
3. Curiosity = encourages range/width, exploration of new fields and topics

### Chapters

_Example: 'Week 1 - Relating' OR 'Research Authentication methods'_
Chapter is primarily a child entity of a module - they represent a cohesive topic requiring several days of work or study.
Chapters can also be standalone and can represent a smaller area of interest or development - those are tagged as elective or career-focused. Students are encouraged to explore those during their time between focused semesters.

**Categories of Chapters:**

1. Regular = in-semester; classic academic chapter, typically part of the module, the default value
2. Elective = out of semester; small-scope interest, to be studied outside of a semester
3. Career = out of semester; practical and career-oriented work (i.e work on CV, portfolio, github)

**Assignments**
_Example: PSET 1 - Moneyball_
Optional child elements of chapters, representing a singular task that usually requires between 1 hour and maximum of one day of work/study.

**Semesters**
_Example: Michaelmas_

The app follows the academic calendar of Cambridge University - 3 shorter semesters (of around 8 weeks), with extra days before and after for examination (this is when students would run mock self-tests, finish and submit projects etc.)

---
