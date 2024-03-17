---
title: "Reviewing Code"
date: "2024-03-01"
comments: true
tags: ["code", "review", "principles"]
---

## Overview
Code reviews are a critical part of the software development process. They help to ensure that the code is of high
quality, that it's maintainable, and that it's secure. They also help to ensure that the code is in line with the
company's goals and values. Code reviews are also a great way to learn from your peers and to share your knowledge
with them.

### Knowledge Sharing
The code review should be a learning opportunity for everyone involved, this could mean as part of the review or
historically when looking back at motivations and decisions.

### Higher Quality
The code review should ensure that the code is of high quality. This means that it should be free of errors and
warnings, that it should run properly, and that it should accomplish the feature(s) it was designed to accomplish.

### Better Maintainability
The code review should ensure that the code is maintainable. This means that it should be easy to read and understand,
that it should be well-documented, and that it should follow coding and technical standards.

### Increased Security
The code review should ensure that the code is secure. This means that it should be free of security vulnerabilities,
that it should not introduce any new security vulnerabilities, and that it should follow security best practices.

### Optimization Opportunities
The code review should consider if the code is efficient, not wasting resources, and is scaleable.

## Priorities
To follow these principles, I try to review code with the following priorities in mind:

> **NOTE**: I realize while writing this, there's a few assumptions about the development environment that I'm making,
> most that a version control system is being used and that the code is being reviewed in a pull request.

1) Is the code functional?

The first thing I try to do is understand if it accomplishes the feature(s) it was designed to accomplish. As a reviewer,
this could mean reading a README and running the code.  When running the code, I try to capture not only the happy path
but also the edge cases and error handling.  As a submitter, this could mean providing these tools for the reviewer,
ideally as unit tests and README documentation.

2) Is the code clean and maintainable?

Secondly, I try to look at the code from cleanliness and maintainability perspective.  To avoid as much subjectivity as
possible, automated linters and static analysis tools should be used.  In addition to these tools, the code should be
well-documented, considering CSI (Comment Showing Intent)[^2] standards.  The CSI Standard should exist alongside
Self-Commenting[^3] Code practices, not instead of.  The code should also have binaries and unnecessary cruft removed.

3) Is the code secure?

Thirdly, I try to look at the code from a security perspective.   Admittedly, this is an area I'm learning more about.
With that said, I delegate much of this to automated tools which cover things like OWASP® Top 10 and CWE/SANS Top 25.

4) Can the code be optimized?

Lastly, I try to look at the code from an optimization perspective.  This means that the code should be efficient and not
waste resources.  It should also be scalable.

## Design and architecture
Something I've been trying to do more of is using an RFCs (Request for Comments) ahead of writing code for larger
changes.  I think about the design and architecture of the code. This is a great way to get feedback on the design and
approach well before the code is written.  This is also a great way to get buy-in from the team on the approach.

## Additional Considerations
Google's [Standard of Code Review](https://github.com/google/eng-practices/blob/master/review/reviewer/standard.md#the-standard-of-code-review)
mentions that the primary goal of the code review is to ensure that "the overall code health of Google's code base is
improving over time". This might be good for a big company like Google, but I feel that if you prioritize people over
code, the code will naturally improve over time.  This is why I like the idea of using code reviews as a learning and
knowledge sharing opportunity.

Additionally, womething that resonated with me from [How to Do Code Reviews Like a Human (Part One)](https://mtlynch.io/human-code-reviews-1/),
is that code reviews should be about the code, not the person.  To help avoid some pitfalls use these techniques
1) never say "you" 2) Frame feedback as requests 3) Tie notes to principles, not opinions.

## Checklist
The following is a checklist that's hopefully useful for pull requests.  The idea is to use these to be consistent in
process and should be applicable for both the openers and reviewers.

Checklist:

- [ ] How
    - Does the code comply with the RFC (Request for Comments), if one exists?
    - Does the code accomplish the feature(s) it was designed to accomplish?
- [ ] What
    - Are there tests? Do they cover the happy path, edge cases, and error handling?
    - Is there documentation? README, CSI, Self-Commenting Code?
    - Are linting and static analysis tools being used? If so, are they passing?
    - Are there any security vulnerabilities? Is the project up to date?
    - Are there any optimization opportunities?
      - Are there opportunities to reduce redundant code ([DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)?
      - Does it follow [SOLID](https://www.digitalocean.com/community/conceptual-articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design) principles?
- [ ] Follow-Up/TODOs
  - [ ] Are there any follow-up items that could be addressed?
- [ ] Feedback
  - [ ] Is the feedback framed as a request?
  - [ ] Is the feedback tied to principles, not opinions?
  - [ ] Does the feedback avoid using "you"?

## References

[^1]: <https://dev.to/codemouse92/10-principles-of-a-good-code-review-2eg>
[^2]: <https://standards.mousepawmedia.com/en/latest/csi.html#commenting-showing-intent-csi>
[^3]: <https://en.wikipedia.org/wiki/Self-documenting_code>
[^4]: <https://github.com/mawrkus/pull-request-review-guide>
[^5]: <https://github.com/google/eng-practices>
