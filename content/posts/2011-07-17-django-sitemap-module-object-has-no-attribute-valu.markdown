---
layout: post
title: "django-sitemap-module-object-has-no-attribute-valu"
date: "2011-07-17"
comments: true
tags: ["django","readthedocs","sitemap.xml","StackOverflow"]
---
I ran into an issue trying to generate a sitemap.xml file with Django's built-in sitemap view.  After reading the documentation over a few times I still received the error:

<blockquote>
Django sitemap: 'module' object has no attribute 'values'
</blockquote>
<!-- more -->
For some reason, it wasn't obvious to me what the confusion was, but clearly others have encountered the issue as well.  A quick google search turned up a question on <a href='http://stackoverflow.com' target='_tab'>StackOverflow<a>.  User <a href='http://stackoverflow.com/users/577902/kub' target='_tab'>KuB</a> had <a href='http://stackoverflow.com/questions/4996177/django-sitemap-module-object-has-no-attribute-values' target='_tab'>asked a question</a> which looked very similar to the one I had just experienced.

After a bit of research and experimentation I was able to resolve the issue and came up with a bit of code that resolved the issue for me:

The full coding sample that I used looks like the following:

sitemap.py file:
```
from django.contrib.sitemaps import Sitemap
from articles.models import Article

class BlogSitemap(Sitemap):
    changefreq = "never"
    priority = 0.5

    def items(self):
        return Article.objects.filter(is_active=True)

    def lastmod(self, obj):
        return obj.publish_date
```

urls.py file:
```
from sitemap import BlogSitemap

# a dictionary of sitemaps
sitemaps = {
    'blog': BlogSitemap,
}

urlpatterns += patterns (''
    #...<snip out other url patterns>...
    (r'^sitemap\.xml$', 'django.contrib.sitemaps.views.sitemap', {'sitemaps': sitemaps}),
)
```

You can find the full thread out on Stack Overflow <a href='http://stackoverflow.com/questions/4996177/django-sitemap-module-object-has-no-attribute-values' target='_tab'>here</a>.
