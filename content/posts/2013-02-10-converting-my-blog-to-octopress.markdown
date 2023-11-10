---
layout: post
title: "Converting my blog to Octopress"
date: "2013-02-10"
comments: true
tags: ["octopress"]
---
Recently I started looking into migrating my blog to something that would be a
little easier to maintain.  My Django powered blog was nice, but there where a
lot of moving parts and required a lot of resource overhead (apache, mysql,
django, etc...).  I enjoy exploring new technologies so I started looking into
static site generators.
<!-- more -->

What I was looking for:
-----------------------

  * Easy to use and learn
  * Straightforward development to live process
  * Somewhat customizable

A quick google search for static site generators pulls up quite a few.  It even
turns up a [github][1] repo from one contributor who maintains a [list][0] of
them. I wasn't really sure where to start and my acceptance criteria wasn't
super restrictive, so I picked the first one that [seemed interesting][2].  This
happened to be [Octopress][3].

Some of the features Octopress touts:
-------------------------------------

  * A [semantic HTML5][4] template
  * A Mobile first [responsive layout][5]
  * Built in 3rd party support for Twitter, Google Plus One, Disqus Comments, Pinboard, Delicious, and Google Analytics
  * An easy deployment strategy
  * Built in support for POW and Rack servers
  * Easy theming with [Compass][6] and [Sass][7]
  * A Beautiful Solarized syntax highlighting

"Octopress is a blogging framework for hackers."
------------------------------------------------

It was incredibly straight forward to get Octopress up and running.  The
[setup documentation][8] was easy to find and follow.

I didn't have the mentioned version of Ruby installed, so I followed the
instructions for the [RVM installation][9].

I then followed the instructions to clone Octopress, installed the dependencies
and install the default theme.

```
git clone git://github.com/imathis/octopress.git octopress
cd octopress
gem install bundler
bundle install
rake install
```

I now had everything in place for a bearbones, uncustomized octopress blog.  Just
to make sure things where working I then tried the local development server:

```
rake generate
rake preview
```

Hit the local url (localhost:4000) in the browser and there it was!

<img src="/images/porting_octopress/bare_bones.png" alt="bare_bones" height='225px' width='500px' />


Customization
-------------
So, I mentioned that I wanted to have some ability to configure the blog.  Meaning
adding a few bells and whistles (like adding some social links, disqus comments,
and some customized css).

Just like setting up the framework, customizations are also super easy.  One can
find the out of the box configuration points within the _config.yml file.

Changing the url, title, subtitle are the first things to configure at the top
of the file.
```
url: http://yoursite.com
title: My Octopress Blog
subtitle: A blogging framework for hackers.
author: Your Name
simple_search: http://google.com/search
description:
```

Plugin configurations are next.  You can change the structure of how the links
are constucted, pagination, etc.  Also, anything listed in the sidebar can be
modified by changing the list of included files in the default_asides setting.

```
# If publishing to a subdirectory as in http://site.com/project set 'root: /project'
root: /
permalink: /blog/:year/:month/:day/:title/
source: source
destination: public
plugins: plugins
code_dir: downloads/code
category_dir: blog/categories
markdown: rdiscount
pygments: false # default python pygments have been replaced by pygments.rb

paginate: 10          # Posts per page on the blog index
pagination_dir: blog  # Directory base for pagination URLs eg. /blog/page/2/
recent_posts: 5       # Posts in the sidebar Recent Posts section
excerpt_link: "Read on &rarr;"  # "Continue reading" link text at the bottom of excerpted articles

titlecase: true       # Converts page and post titles to titlecase

# list each of the sidebar modules you want to include, in the order you want them to appear.
# To add custom asides, create files in /source/_includes/custom/asides/ and add them to the list like 'custom/asides/custom_aside_name.html'
default_asides: [asides/recent_posts.html, asides/github.html, asides/twitter.html, asides/delicious.html, asides/pinboard.html, asides/googleplus.html]

# Each layout uses the default asides, but they can have their own asides instead. Simply uncomment the lines below
# and add an array with the asides you want to use.
# blog_index_asides:
# post_asides:
# page_asides:
```

Any fun widgets like github repos, or social links are configured from
within the 3rd Party plugin section.

```
# Github repositories
github_user:
github_repo_count: 0
github_show_profile_link: true
github_skip_forks: true

# Twitter
twitter_user:
twitter_tweet_count: 4
twitter_show_replies: false
twitter_follow_button: true
twitter_show_follower_count: false
twitter_tweet_button: true

# Google +1
google_plus_one: false
google_plus_one_size: medium

# Google Plus Profile
# Hidden: No visible button, just add author information to search results
googleplus_user:
googleplus_hidden: false

# Pinboard
pinboard_user:
pinboard_count: 3

# Delicious
delicious_user:
delicious_count: 3

# Disqus Comments
disqus_short_name:
disqus_show_comment_count: false

# Google Analytics
google_analytics_tracking_id:

# Facebook Like
facebook_like: false
```

Lastly, I modified some css to `personalize` the look and feel.  I changed the
background color and added an image (I'm not a designer, so this is always magic
to me:).  It was straight forward to add a custom.css stylesheet to the
source/stylesheets directory and then link to it in the
source/_includes/custom/header.html file.

All the changes can be viewed in my personal fork of octopress: [https://github.com/johncosta/octopress][10]


Porting The Existing Data
-------------------------

I didn't have a lot of blog entries so I manually moved all my data over.  I
had articles written in html and restructured text so most of it
ported over almost directly.  I made a few adjustments to make sure that the
urls matched the existing urls so that any links carried over.  I'm sure that
I could have written a script to extract the data and format it into a post file
but this was just as easy.

```
rake new_post['the title of the article']
```
Then it was a matter of cutting and pasting in the previous text and then change
the name of the post file to match the url that the article was previously
hosted at.

Rinse and repeat.



[0]: https://github.com/jaspervdj/static-site-generator-comparison of them.
[1]: https://github.com
[2]: http://siliconangle.com/blog/2012/03/20/5-minimalist-static-html-blog-generators-to-check-out/
[3]: http://octopress.org/
[4]: http://en.wikipedia.org/wiki/Semantic_HTML
[5]: http://en.wikipedia.org/wiki/Responsive_web_design
[6]: http://www.webresourcesdepot.com/compass-a-powerful-stylesheet-framework/
[7]: http://sass-lang.com/
[8]: http://octopress.org/docs/setup/
[9]: http://octopress.org/docs/setup/rvm/
[10]: https://github.com/johncosta/octopress
