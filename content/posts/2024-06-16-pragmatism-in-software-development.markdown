---
title: "Pragmatism for decision-making in Software Development"
date: "2024-06-16"
comments: true
tags: ["software", "development", "pragmatism"]
---

## Overview

This post discusses pragmatism as a tool in Software Development. I consider myself to be pragmatic in my approach to
software engineering, and wanted to explore the concept a little more.

## What is pragmatism?

Pragmatism[^1] is a philosophical tradition that began in the United States around 1870. It is a way of thinking that
focuses on the practical consequences of actions rather than on abstract principles. Pragmatists believe that the truth
of an idea is determined by its usefulness in solving real-world problems. They are concerned with what works, rather
than with what is theoretically correct.

## Pragmatism in software development

Pragmatism can be a powerful tool in software development. Software projects can be complex, with lots of moving parts,
and there's lots of opportunity for things to go wrong, extending timelines and risking value delivery. Pragmatism can
help you make decisions that are practical and effective, rather than getting bogged down in theoretical debates.

Some goals for pragmatism in software development can be distilled into the following:

* deliver value to the customer (users and/or organization)
* maximize stakeholder satisfaction
* minimize stakeholder dissatisfaction

## Looking around for inspiration

I looked around to see if there's any existing work on pragmatism in software development. I found a few interesting
papers, articles, and books that I wanted to share.

### Optimization in Software Engineering - A Pragmatic Approach

Guenther Ruhe[^2] published a paper on `Optimization in Software Engineering - A Pragmatic Approach`[^3]. The paper
takes a process-based approach and includes a checklist for performing the optimization process. This process includes:

* Scoping and Problem analysis
* Modeling and Problem formulation
* Solution Design
* Data collection
* Optimization
* Validation
* Implementation
* Evaluation

Each checklist is a series of questions that are categorized into three types.

* M(andatory) questions need to be answered with ”yes” to make optimization a valuable effort.
* C(larification) questions (What?) are aimed to qualify the setup of the whole process.
* TMTB questions(How? How much?) are the ones that benefit from ”the more the better”.

#### Scoping and Problem analysis

| Question                                                               | Category  |
|------------------------------------------------------------------------|-----------|
| Can the problem not be solved easily without optimization?             | M         |
| What are alternative solution approaches?                              | C         |
| What is part of the investigation, what is not?                        | C         |
| Who are the key stakeholders and decision-makers?                      | C         |
| How important is the problem?                                          | TMTB      |
| How much time and money can be invested to solve the problem?          | TMTB      |
| How much is the optimization problem aligned with business objectives? | TMTB      |
| How much impact has an optimized solution in the problem context?      | TMTB      |

#### Modeling and Problem formulation

| Question                                                      | Category |
|---------------------------------------------------------------|----------|
| What are the key independent problem variables?               | C        |
| What is a reasonable granularity for problem formu- lation?   | C        |
| What are the dependent variables?                             | C        |
| What are the human resource, budget, and time con- straints?  | C        |
| What are the technological constraints?                       | C        |

#### Solution Design

| Question                                                                                                 | Category |
|----------------------------------------------------------------------------------------------------------|----------|
| What baseline solution exist to compare with?                                                            | C        |
| What are possible solution method alternatives and which ones have proven successful in similar context? | C        |
| Which related tools  exist?                                                                              | TMTB     |
| What are the expectations on optimization solutions (heuristic vs approximation vs exact)?               | C        |
| Is it search for just one (optimized) solution or for a set of solutions?                                | C        |
| What scenarios are planned for running the algorithms?                                                   | C        |
| How much would the optimization process benefit from interaction with the decision makers?               | TMTB     |

#### Data collection

| Question                                             | Category |
|------------------------------------------------------|----------|
| Is all necessary information available?              | M        |
| Is all available information also reliable?          | TMTB     |
| Is there a need for data cleaning?                   | C        |
| Is there agreement between stakeholders on the data? | TMTB     |

#### Optimization

| Question                                                                                                                 | Category |
|--------------------------------------------------------------------------------------------------------------------------|----------|
| Which parameter settings are made and why?                                                                               | C        |
| Should the parameter settings be varied and if so, how?                                                                  | C        |
| For randomized algorithms (e.g., bio-inspired algo- rithms), how many replications are needed to make sound conclusions? | C        |
| Is there a time constraint for running the solution algorithm?                                                           | C        |
| What are the termination criteria for the optimization algorithm?                                                        | C        |

#### Validation

| Question                                                                  | Category |
|---------------------------------------------------------------------------|----------|
| How much do the generated solutions make sense in the problem context?    | TMTB     |
| How much do stakeholders agree with the proposed solution(s)?             | TMTB     |
| In case of conflicts, how they can be resolved?                           | C        |
| How robust is the proposed solution against changes of input data?        | TMTB     |

#### Implementation

| Question                                                                                                             | Category |
|----------------------------------------------------------------------------------------------------------------------|----------|
| Are the additional considerations to select one solu- tion for final implementation in the original problem context? | C        |
| Is there any need to adjust the proposed solution to the actual problem context?                                     | C        |

#### Evaluation

| Question                                                                | Category |
|-------------------------------------------------------------------------|----------|
| How much does the implemented solution solve the original problem?      | TMTB     |
| How much the implemented solution is accepted by included stakeholders? | TMTB     |
| How much the implemented solution improves the baseline?                | TMTB     |


## Further reading on Pragmatism

* https://blog.liblab.com/pragmatic-engineers-philosophy-first-part/
* https://arxiv.org/pdf/1912.02071
* https://pkritiotis.io/technical-decision-making-fast-paced-environments/

## Futher reading on Product Driven Development

* https://www.lyssna.com/blog/product-driven-development/
* https://read.highgrowthengineer.com/p/ultimate-guide-to-product-engineer

[^1]: https://en.wikipedia.org/wiki/Pragmatism
[^2]: https://ruhe.cpsc.ucalgary.ca/publications/publications.html#books
[^3]: https://arxiv.org/pdf/1912.02071
