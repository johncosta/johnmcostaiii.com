---
title: "Scaling with GitHub Action Workflows" 
date: "2023-11-18"
comments: true
tags: ["GitHub Actions", "CI/CD", "DevOps"]
---

# Overview
Platform engineering has become increasingly more popular in recent years. The idea of a platform team is to provide a 
set of tools and services that enable other teams to build and deploy their applications, ideally at scale. This allows 
teams to focus on their core competencies and not have to worry about the underlying infrastructure.

There's plenty of great resources out there that go into detail about what a platform team is and how to build one.

At the core of any platform team is most likely an IDP, or internal developer portal. This is a place where developers
can go to find documentation, guides, and other resources that will help them build and deploy their applications.

For a single developer, an internal developer portal is probably overkill. That said, there's still concepts which can 
be applied to help scale development, if desired. 

## Scaling with GitHub Action Workflows.
In this post, I'll be going over how I've used GitHub Actions to scale my development efforts, something I've become 
accustomed to for workflow standardization.  I'm sure there's optimizations that can be made, but this is what I've
found to work for me right now.

### The Problem
I've been working on a few projects recently that I'd like to have similar workflows, templates, and linting.  After the 
third project, I realized that I was copying and pasting a lot of the same code over and over again.  This is not ideal
for a few reasons, but mainly if I want to make a change to the workflow, I would have to make the change in multiple 
places.

### A Solution
There's probably a few different solutions to this sort of problem. I decided to use GitHub Actions Workflows to solve
it. I created a repository called `template-repository` and added a few workflows to it, like linting.  I then created
a new repository called `workflow-templates` and added a workflow which 
    
    1) check out the source repository, "template-repository" 
    2) check out the target repository
    3) copy the workflows from the source repository to the target repository
    4) commit and push the changes to the target repository
    5) open a pull request for the changes

Here's a version of the repository copy workflow:

```yaml
name: Add linter to repository

permissions:
  pull-requests: write
  contents: write

on:
  workflow_dispatch:
    inputs:
      source_namespace:
        required: true
        type: string
        description: The namespace to copy the templates from.
        default: "johncosta"
      source_repository:
        required: true
        type: string
        description: The repository to copy the templates from.
        default: "template-repository"
      source_tag:
        required: true
        type: string
        description: The version tag to checkout for templates.
        default: v0.0.1
      target_namespace:
        required: true
        type: string
        description: The namespace to copy the templates to.
        default: "johncosta"
      target_repository:
        required: true
        type: choice
        description: The repository to copy the templates from.
        options:
          - johnmcostaiii.com
          - johnmcostaiii.net
          - smart-oil-api-python
          - U6143-ssd1306-golang
          - documentation
      target_tag:
        required: true
        type: string
        description: The version tag to checkout for templates.
        default: main
      committer_name:
        required: true
        type: string
        description: The users name to use for the commit.
        default: "John Costa"
      committer_email:
        required: true
        type: string
        description: The users email to use for the commit.
        default: "john.costa@gmail.com"

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          repository: ${{ github.event.inputs.source_namespace }}/${{ github.event.inputs.source_repository }}
          ref: ${{ github.event.inputs.source_tag }}
          path: ./src/${{ github.event.inputs.source_namespace }}/${{ github.event.inputs.source_repository }}

      - uses: actions/checkout@v4
        with:
          repository: ${{github.event.inputs.target_namespace}}/${{ github.event.inputs.target_repository }}
          ref: ${{ github.event.inputs.target_tag }}
          path: ${{github.workspace}}/src/${{github.event.inputs.target_namespace}}/${{ github.event.inputs.target_repository }}

      - name: Modify files
        run: |
          SOURCE_FOLDER=${{github.workspace}}/src/${{github.event.inputs.source_namespace}}/${{ github.event.inputs.source_repository }}
          TARGET_FOLDER=${{github.workspace}}/src/${{github.event.inputs.target_namespace}}/${{ github.event.inputs.target_repository }}
          TARGET_BRANCH="update-templates-${{ github.event.inputs.source_tag }}"
          
          # Copy the files from the source to the target
          cd ${TARGET_FOLDER}
          mkdir -p ${TARGET_FOLDER}/.github/linters
          mkdir -p ${TARGET_FOLDER}/.github/workflows
          cp -r ${SOURCE_FOLDER}/.github/linters ${TARGET_FOLDER}/.github/linters
          cp -r ${SOURCE_FOLDER}/.github/workflows/linter.yml ${TARGET_FOLDER}/.github/workflows/linter.yml

      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v5
        with:
          token: ${{ secrets.ACCESS_TOKEN }}
          path: ${{github.workspace}}/src/${{github.event.inputs.target_namespace}}/${{ github.event.inputs.target_repository }}
          title: "chore: update linter workflow to ${{ github.event.inputs.source_tag }}"
          commit-message: "chore: linter workflow to ${{ github.event.inputs.source_tag }}"
          base: "main"
          branch: "update-linter-workflows-${{ github.event.inputs.source_tag }}"
```

You'll notice that I'm using the `peter-evans/create-pull-request` action to create the pull request.  This is a great
action which helps both commit the changes and open a pull request for them.

To make this workflow work, I had to create a personal access token with the `pull-requests: write` and 
`contents: write` permissions. I then added the token as a secret to the repository.

Lastly, this is a workflow dispatch workflow, which means that it can be triggered manually.  This is great because it
allows me to trigger the workflow whenever I want to update the workflows in a repository.  To ensure that I don't point 
to the wrong repository, I've added a few input parameters to the workflow.  This allows me to specify the source and
target repositories, as well as the source and target tags.  This is useful because I can point to a specific version
of the source repository, and then update the target repository to use that version.

## Conclusion
This is just one example of how I've used GitHub Actions to scale my development efforts.  I'm sure there's other ways
to do this, but this is what I've found to work for me right now.  I'm sure there's optimizations that can be made, and 
I'm always looking for feedback.  Feel free to reach out to me on [Twitter](https://twitter.com/johnmcostaiii) or in the
comments below. Thanks for reading!
