---
layout: post
title: "Migrating a Mercurial Repository"
date: "2011-08-08"
comments: true
tags: ["BitBucket","Import","Mercurial","Repository","Webfaction"]
---
<p>When I first started playing with Python and Django, I was introduced to Mercurial.  I had used Subversion for a while and once familiar with Mercurial, there was no going back (well...when I had the choice ;-) ).  I've posted before that I use WebFaction as a host for my personal projects.  This hosting also included setting up my own Hg server.  I was happy, until <a href='http://kencochrane.net/' target='_tab'>Ken Cochrane</a> turned me on to <a href='http://bitbucket.org/' target='_tab'>BitBucket.</a> </p>

<!-- more -->

<p>I've been using BitBucket off and on for about a year now.  My old projects have remained in my WebFaction repository, but my new projects have been going into BitBucket.  No complaints. It has been solid and reliable. I can even setup SSH public keys for all my machines accessing the account.  A plus when compared with my personal hosting.  </p>

<p>So, it occurred to me. How do I convert all my projects over to BitBucket? As with most tasks I haven't yet encountered I look to my friend Google to see if someone has solved the task in some trivial way.  I should have realized how simple it was, but I'm glad I checked.</p>

<ul>
    <li> Create a project at BitBucket.org</li>
    <li> Clone a repo from the old repository. Ensure everything is up to date with latest code and tags.</li>
    <li><p> Change the .hg/hgrc file to point to the new Bit bucket repository</p>

<p>The old .hg/hgrc file</p>
```
[paths]
default = https://hg.my.hosting.site.url/myproject
```

<p> The new .hg/hgrc file</p>
```
[paths]
default = ssh://hg@bitbucket.org/user account/project name
```

</li>
<li>hg push</li>
</ul>

<p>Yep, that's all it took. I love Hg.</p>

<p>Inspired by Andrew Frayling's post <a href='http://sphericalnemesis.blogspot.com/2011/02/bitbucket-import.html' target='_tab'>Bitbucket Import</a></p>

<p><a href='http://bitbucket.org' target='_tab'><img src='http://upload.wikimedia.org/wikipedia/en/7/73/Bitbucket.png' /></a></p>
