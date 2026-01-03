---
title: "Book Notes: The Mythical Man Month: Essays on Software Engineering"
date: "2025-12-30"
comments: true
tags: ["Software Engineering", "Engineering Management", "Project Management", "Team Dynamics", "Software History", "Engineering Culture"]
categories: ["book notes"]
---

## Overview

This post contains my notes on the book Team Topologies: Organizing Business and Technology Teams for Fast Flow by Matthew Skelton, Manuel Pais, and Ruth Malan.

You can find the book on [Amazon](https://www.amazon.com/dp/0201835959/?bestFormat=true&k=the%20mythical%20man-month%20by%20fred%20brooks&ref_=nb_sb_ss_w_scx-ent-bk-ww_k2_1_18_de&crid=1TQ3Z724DK40&sprefix=Mythical%20Man%20Month)

I'll be adding my notes to this post as I read through the book. The notes will be organized by chapter and will include key concepts, code examples, and any additional insights I find useful.

## Chapter 1: The Tar Pit

Programming Systems Product
- Programming Product costs ~3x as much as a debugged program w/ same function

The Joys of the Craft
1) Making Things
2) Making things that are useful
3) Fashioning complex puzzle-like objects
4) Always learning
5) Delight of medium

The Woes of the Craft
1) Perfection
2) Other people's objectives
3) Other people's systems
4) finding bugs is work
5) product appears obsolete before finished

Challenge and Mission: to find real solutions to real problems on actual schedules with available resources.

## Chapter 2: The Mythical Man-Month

Calendar Time Causes Issues
1) Estimating is poorly developed
2) Estimating techniques confuses effort with progress
3) Estimates are uncertain
4) Schedule progress is poorly monitored
5) Natural Reaction to Schedule Slippage is to add manpower

Optimism: All programmers are optimists

Creative activities:
1) idea
2) implementation
3) interaction

Incompleteness and Inconsistencies become clear during implementation.

### The man-month

Cost = # of programmers * number of months

The bearing of a child takes 9 months, no matter how many women are assigned.

Project Planning Rules:
- 1/3 Planning
- 1/6 Coding
- 1/4 component/system test
- 1/4 system test

### Gutless Estimating

- Develop and Publicize productivity Figures
- bug-incidence figures
- estimating rules

Brook's Law: Adding manpower to a late software project makes it later.

## Chapter 3: The Surgical Team

Team Composition
- 1 Surgeon: chief programmer, system architect
- 1 Co-Pilot: backup programmer, assistant architect
- 1 Administrator: handles clerical work
- 1 Editor: proofreads documentation
- 2 Secretaries: handle typing
- 1 program clerk: maintains program library
- 1 Toolsmith: builds and maintains programming tools
- 1 Tester: designs and runs tests
- 1 Language Lawyer: expert in programming language

1) Surgeon and Co-Pilot do all design and coding
2) Surgeon makes unilateral decisions

## Chapter 4: Aristocracy, Democracy, and System Design

Conceptual integrity: system has a single, consistent design approach
- Most important consideration in system design
- Purpose: Ease of use

Ratio of function to conceptual complexity: test of system design

Aristocracy and Democracy
- Conceptual Integrity -> design from one mind, or from a very small number of agreeing resonant minds
- Scheduling Pressures -> Many hands

1) division of labor between architecture and implementation
2) structure programming implementation teams (surgical teams)

Separation of architectural effort from implementation effort is essential to conceptual integrity for large projects.
- Architecture: Complete and detailed specification of the user interface
- Architect: user's agent, professional/technical knowledge
- Architecture: What
- Implementation: How

Good features/ideas that do not integrate with the system should be dropped.

## Chapter 5: The Second-System Effect

Architect: works against a budget
Iteration: bids->estimation upward, design downward

High Estimate:
- cut the design or
- challenge the estimate by suggesting cheaper implementations

things to remember:
- builder has inventive/creative responsibility -> suggest, not dictate
- suggest a way of implementing anything specified, accept any other way to meet objectives
- deal quietly and privately w/ suggestions
- forgo credit for ideas suggested

### Self-Discipline

First Work -> Spare and Clean
Second system -> tendency to over design

## Chapter 6: Passing the Word

### Written Specifications

Manual: External Specification
- describes and prescribes every detail

Formal Definitions
- precise definitions

A programmed simulator can be used as a formal definition

### Conferences and Courts

Meetings are necessary
- Weekly half-day conference of all architects
    - propose problems/changes distributed in writing
    - discuss and decide
    - chief architect decides if no consensus
    - minutes kept and distributed
    - appeals possible
- Annual court session
    - two week long meeting
    - backlog of minor appeals, open issues, disgruntlements

Benefits:
- same group: no time needed to bring people up to date
- well versed in project: better decisions
- deeply involved in outcome
- problems -> solution within boundaries
- formality of proposals focuses attention and forces decision
- vesting of decision in chief architect avoids compromise and delay

### Telephone Log
- Record each question and answer
- Logs of architects are concatenated, produced, and distributed weekly

### Product Test
- independent technical auditing group
- customer is independent auditing group

## Chapter 7: Why Did the Tower of Babel Fail?

A successful project needs:
- Clear Mission
- Manpower
- Materials
- Time
- Technology
- Communication
- Organization

Options for communication:
1) Informal: Telephone service, clear definition of intergroup dependencies
2) Meetings: regular technical briefings
3) Workbook: written records of decisions

Project Workbook:
- What: structure of documents
- Why:
  1) early design of structure ensures structure is crafted
  2) control of distribution of information
- Mechanics:
  1) Everyone should have access
  2) Timely updates
  3) Continual Maintenance: diff of change, summary of changes

Organization:
- Purpose: reduce communication/coordination overhead
- Principle: No man can serve two masters
- Organization: division of labor + specialization of function
- Organization subtree need:
  1) mission
  2) producer
  3) technical director/architect
  4) division of labor
  5) interface definitions among parts
- Role of Producer:
  - assembles team, divides work, establish schedule, acquires resources
  - Establishes communication outside team, upwards and sideways
  - Ensures schedule met, shifting resources and organization
- Role of Technical Director/Architect:
  - conceives design to be built, identifies sub-parts, specifies how it will look
  - unity and conceptual integrity
  - invents solutions and shifts design to solve technical problems
- Producer could be the same as Technical Director/Architect
  - strong management and strong technical talen is rarely found in one person

Rare: Thinkers
Doers: Rarer
Thinker-Doers: Rarest

- Producer might be boss w/ director as right hand
- Director might be boss w/ producer as right hand

## Chapter 8: Calling the Shot

### Estimating

What not to do:
- estimate coding portion and apply ratios from earlier
- errors in the estimate or ratios could lead to large errors in schedule

small program estimation != large program estimation

Estimating misses often due to missed:
- short unrelated jobs
- meetings
- paperwork
- company business
- sickness
- personal time

Productivity = thought per statement + errors it includes
Productive time = x5 when high-level language used

## Chapter 9: Ten Pounds in a Five-Pound Sack

### Program Space as Cost

Size is a large part of the user cost of a programming system product

Size itself isn't bad, but unnecessary size is.

### Size Control

Project Manager: size control = technical and managerial

1) budget for all aspects of size
set total size budgets as well as space budgets for major components

2) Define exactly what a module must do when you specify how big it must be.

3) Total-system, user-oriented attitude may be the most important function of the programming manager

### Space Techniques

Space Budgeting + Control != small program
small programs require invention and craftsmanship

Space time tradeoffs
- ensure team is trained in programming technique
- recognize programming has a technology and components needs to be fabricated

### Representation is the essence of programming

rethinking the overall strategy (especially how data is represented) instead of code tricks can lead to innovation

## Taxonomy

## References:
