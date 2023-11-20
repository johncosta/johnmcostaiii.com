---
title: "Git Hooks with Pre-Commit Framework"
date: "2023-11-20"
comments: true
tags: ["pre-commit", "git-hooks", "developer experience", "GitHub Actions", "CI/CD", "DevOps"]
---

# Overview
Pre-commit is a framework for managing and maintaining multi-language pre-commit hooks. It is a great tool for ensuring
consistency across a set of projects or a team. Not only can it help with consistency, but it can also help with
formatting by automatically formatting files before they are committed.

## What is a git hook?[^1][^2]
Git hooks are scripts that run before or after certain git commands. They are stored in the `.git/hooks` directory of
your repository. Git hooks are not stored in the repository itself, so they are not version controlled. This means that
if you want to share a git hook with your team, you will need to share the script itself.

## What is pre-commit?
Pre-commit solves the problem of sharing git hooks with your team and storing configurations with a project repository.
This framework allows for management of git hooks commonly across any project.

## Setting up pre-commit
Pre-commit is a python package that can be installed with pip. If you're using macOS, you can install it with brew.

## Install Configuration
Pre-commit uses a configuration file to determine which hooks to run and how to run them. This configuration file is
stored in the root of your project and is named `.pre-commit-config.yaml`. This file is used to configure the hooks that
will be run and the order in which they will be run.

To generate an initial version of the file, you can run `pre-commit sample-config > .pre-commit-config.yaml`. This will
generate a sample configuration file with a few available hooks.

Once pre-commit is installed, you can run `pre-commit install` to install the git hooks.  Now, when you run `git commit`,
the hooks will run before the commit is created. If any of the hooks fail, the commit will be aborted.

## Prescriptive Hook Choices
Pre-commit has a large number of hooks available. Some are more useful than others, most being language specific. Here's
a list of the hooks I like to use for every project.

```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v2.3.0
    hooks:
# file
      - id: end-of-file-fixer
        description: Fixes missing end-of-file newline in files.
      - id: mixed-line-ending
        args: ['--fix=lf']
        description: Forces to replace line ending by the UNIX 'lf' character.
      - id: trailing-whitespace
        description: Trims trailing whitespace.
      - id: check-added-large-files
        args: ['--maxkb=100']
        description: Checks for large files being added to git.
# format
      - id: check-yaml
        description: Checks that all yaml files are valid.
      - id: check-json
        description: Checks that all json files are valid.
      - id: check-toml
        description: Checks that all toml files are valid.
```

### End of File Fixer
This hook ensures that all files have a newline at the end of the file. This is a common issue when working with
multiple operating systems. Windows uses `\r\n` for newlines, while Linux and macOS use `\n`. This hook will ensure
that all files have a newline at the end of the file.

Not having a newline isn't just bad style, it can break some tools. [^4] For example, if you have a file that contains
the following (without end of file character):

```bash
first line
second line
```

now if you run `wc -l file`, you will get the following output, indicating only one line in the file.

```bash
% cat file
first line
second line
% wc -l file
       1 file
```
This is because of how POSIX defines a line. POSIX defines a line as a sequence of zero or more non-\<newline\>. [^5][^6]

### Mixed Line Ending
If you're working in a mixed environment where developers are using different operating systems, this hook will ensure
that all files have the same line endings. This hook will convert all line endings to the specified type. In the
configuration above, I have it set to `lf` for Linux/Unix line endings as most (all?) of my software is intended to run
on Linux or some Linux variant.

### Trailing Whitespace
Whitespace differences can be picked up by source control systems and flagged as diffs, causing frustration for
developers. This hook will remove all trailing whitespace from files making for a more consistent experience.

### Check Added Large Files
Git is notorious for not handling large files well. There's a bunch of information out there supporting this. This hook
will check for large files being added to the repository.

### Check YAML, JSON, TOML
Errant commas, missing quotes, and other syntax errors can be difficult to find in configuration files. These hooks will
check for syntax errors in the specified file types.

[^1] https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks#:~:text=The%20pre%2Dcommit%20hook%20is,to%20inspect%20in%20the%20code.
[^2] https://git-scm.com/docs/git-hook
[^3] https://pre-commit.com
[^4] https://stackoverflow.com/questions/5813311/whats-the-significance-of-the-no-newline-at-end-of-file-log
[^5] https://stackoverflow.com/questions/729692/why-should-text-files-end-with-a-newline
[^6] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206

## Conclusion
Pre-commit is a great tool for ensuring consistency across a set of projects or a team. It can also help with
formatting by automatically formatting files before they are committed. This can be especially useful when working with
a team that has different preferences for formatting. Pre-commit can be used to ensure that all files are formatted
consistently.
