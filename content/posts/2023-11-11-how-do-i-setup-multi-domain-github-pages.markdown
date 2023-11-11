---
title: "How do I setup multi-domain GitHub pages?"
date: "2023-11-11"
comments: true
tags: ["GitHub","pages","blog","hosting","digitalocean"]
---

Credit goes to [this](https://stackoverflow.com/questions/16454088/can-GitHub-pages-cname-file-contain-more-than-one-domain) Stack Overflow answer,
but note, not the accepted answer it's the one currently below.

1) Create an extra repository for your domain. I used the name of the domain as the repository name. See <https://GitHub.com/johncosta/johnmcostaiii.net>.

2) Create  an index.html file in the root of the project.

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Redirecting to https://johnmcostaiii.com</title>
    <meta http-equiv="refresh" content="0; URL=https://johnmcostaiii.com">
  </head>

  <link rel="canonical" href="https://johnmcostaiii.com">
</html>
```

3) Create a CNAME file in the root of the project.

```shell
johnmcostaiii.com
```

4) Setup the DNS for the domain to point to the GitHub pages servers. See this write up for how it should look: <https://johnmcostaiii.com/posts/2023-11-10-new-blog-hosting/>
