---
title: "New Blog Hosting"
date: "2023-11-10"
comments: true
tags: ["github","pages","blog","hosting","digitalocean"]
---

It was recently suggested by a mentor that I get back into blogging.  I'll create an entry dedicated on 
this topic, but the byproduct of this discussion inspired me to resurface and re-host the blog I had 
started over 10 years ago.

## Choosing the Static Site Generator

Given I already had some content formatted in Markdown and the old site which used a version of Hugo, I didn't 
really spend a significant amount of time re-considering a static site to drive it. 

I did take a few moments to see what was out there and found this list of [Awesome Static Generators](https://github.com/myles/awesome-static-generators). 
I also peeked at reddit to see if there was [any consensus out there](https://www.reddit.com/r/webdev/comments/121jhdw/whats_the_best_static_site_generator_currently/), 
but as expected there was little and it was mostly opinion based. 

Gitlab has a write-up [suggesting an approach static site generator](https://about.gitlab.com/blog/2022/04/18/comparing-static-site-generators/)
which was a little closer to what I was hoping to read through, but they didn't draw any conclusions.  This was also not 
unexpected as they probably can't really back one vs another as they could host any of them.

<!-- more -->
To summarize the article, see the following table:

| Generator   | Language      | Templating Engine | Features                                                                                        | Community and Support                                                               |
|-------------|---------------|-------------------|-------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| Hugo        | Go            | Markdown          | Cross-platform, statically compiled Go binary                                                   | - Thriving community, prebuilt themes, and starter repositories                     |
| Zola        | Rust          | Tera              | Strongly opinionated, prebuilt binary, fast setup                                               | - Limited plugin ecosystem, content-driven focus                                    |
| Jekyll      | Ruby          | Liquid            | Inspired static sites, Liquid templating language, vast plugin ecosystem                        | - Beginner-friendly, over 200 plugins, themes, and resources                        |
| Hexo        | NodeJS        | Nunjucks          | NodeJS-based, built-in support for Markdown, front matter, and tag plugins                      | - Specializes in markup-driven blogs, supports multiple templating engines          |
| GatsbyJS    | React         | GraphQL           | React-based, optimized for speed, extensive plugin library, supports data pulling from multiple sources | - "Content mesh" philosophy, 2000+ community-contributed plugins                    |
| Astro       | JavaScript    | Varies            | Bring Your Own Framework (BYOF), no package dependencies, supports partial hydration            | - Flexibility, future-proof for migrations, online playground for trying features   |

## Setup

I'm a little embarassed to admit this, but I've been late to the party in using [GitHub pages](https://pages.github.com/). Instead, I had a container running the site on a droplet on DigitalOcean.  One of the best parts of the move is 
that I'll be able to save a little on hosting costs. And by save a little, I mean can start another project for a similar cost :)

Here's some of the steps I needed to take to move it over:

1) Create a new GitHub repository. So that I can find it easier later on, I used the domain as the repository name. See the repository here: https://github.com/johncosta/johnmcostaiii.com

2) I looked through the Hugo theme site for a theme that I wanted: https://themes.gohugo.io/

3) Following the [hugo guide posted here](https://gohugo.io/hosting-and-deployment/hosting-on-github/#prerequisites) I then created
   a new hugo site with the following command:

   ```bash
   hugo new site quickstart
   cd quickstart
   git checkout <the theme> themes/<theme name>
   echo "theme = '<theme name'" >> hugo.toml
   hugo server 
   ```
  
   **_NOTE:_** The guide uses the `ananke` theme, but I wanted something different.

4) Move the generated content out of quickstart and into the root. 

   **_NOTE:_** I did this to avoid the complexity of a directory.  Now everything can run from the root.

5) Copy all my content into the `content` directory

6) Test the site with `hugo server`. 

  **_NOTE:_** I created a Makefile to start encapsulating the raw commands. 

## GitHub Actions Workflows

1) Copy and paste the action workflow into the project 

### .github/workflows/hugo.yml
```yaml
# Sample workflow for building and deploying a Hugo site to GitHub Pages
name: Deploy Hugo site to Pages

on:
  # Runs on pushes targeting the default branch
  push:
    branches:
      - main

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# Sets permissions of the GITHUB_TOKEN to allow deployment to GitHub Pages
permissions:
  contents: read
  pages: write
  id-token: write

# Allow only one concurrent deployment, skipping runs queued between the run in-progress and latest queued.
# However, do NOT cancel in-progress runs as we want to allow these production deployments to complete.
concurrency:
  group: "pages"
  cancel-in-progress: false

# Default to bash
defaults:
  run:
    shell: bash

jobs:
  # Build job
  build:
    runs-on: ubuntu-latest
    env:
      HUGO_VERSION: 0.120.2
    steps:
      - name: Install Hugo CLI
        run: |
          wget -O ${{ runner.temp }}/hugo.deb https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb \
          && sudo dpkg -i ${{ runner.temp }}/hugo.deb          
      - name: Install Dart Sass
        run: sudo snap install dart-sass
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: recursive
          fetch-depth: 0
      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v3
      - name: Install Node.js dependencies
        run: "[[ -f package-lock.json || -f npm-shrinkwrap.json ]] && npm ci || true"
      - name: Build with Hugo
        env:
          # For maximum backward compatibility with Hugo modules
          HUGO_ENVIRONMENT: production
          HUGO_ENV: production
        run: |
          hugo \
            --gc \
            --minify \
            --baseURL "${{ steps.pages.outputs.base_url }}/"          
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v2
        with:
          path: ./public

  # Deployment job
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v2
```

## Deployment

GitHub has a guide for setting up static sites which can be found here: https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site

1) Set up your domain registrar. Here it points to Digital Ocean as I manage projects through them. 

![Godaddy Settings](/img/new-blog-hosting/godaddy-settings.png)

2) Get the ip values for your GitHub pages. Mine is johncosta.github.io

```bash
% dig johncosta.github.io

; <<>> DiG 9.10.6 <<>> johncosta.github.io
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12535
;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;johncosta.github.io.		IN	A

;; ANSWER SECTION:
johncosta.github.io.	3600	IN	A	185.199.111.153
johncosta.github.io.	3600	IN	A	185.199.108.153
johncosta.github.io.	3600	IN	A	185.199.110.153
johncosta.github.io.	3600	IN	A	185.199.109.153

;; Query time: 40 msec
;; SERVER: 192.168.87.16#53(192.168.87.16)
;; WHEN: Fri Nov 10 18:50:54 EST 2023
;; MSG SIZE  rcvd: 112
```

3) Setup Digital Ocean to point to GitHub

![DigitalOcean Settings](/img/new-blog-hosting/digital-ocean-settings.png)

4) Set the custom domain in the GitHub Pages Settings section of the repository:

![GitHub Settings](/img/new-blog-hosting/github-settings.png)


