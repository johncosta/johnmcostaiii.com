---
layout: post
title: "New Relic's Python App Public Beta"
date: "2011-09-13"
comments: true
tags: ["NewRelic"]
---
<p>I recently made the trek to Portland, OR for #djangocon. Demo'd there was <a href='http://newrelic.com/' target='_tab'>New Relic's</a> Real-Time Performance tool, complete with a new implementation for Python apps!  This seemed like some fantastic software, but I was skeptical as to how easy it would be to install.  As an experiment, I used their public beta invite on this blog.</p>
<!-- more -->

<p>I'd like to first point out, that the documentation to configure the the app was excellent and abundant.  The software was bundled with an install file that was  located in the root of their distribution (easy to find) and straight forward (easy to follow).  I don't have in my notes exactly where I downloaded the installation package. However I did so and received version "newrelic-0.5.17.47.tar.gz"</p>

<p>Because I use Virtualenv and Pip for dependency management, I added the following line to my requirements file.

<pre>
http://download.newrelic.com/python_agent/beta/newrelic-python-0.5.16.46.tar.gz
</pre>

This was the most challenging part of the installation process.  It wasn't clear where this endpoint was located.  While the documentation listed "http://host/path/to/newrelic-python-A.B.C.D.tar.gz" as the location, I had to ferret out the app version.  Listed in the agent download page for the python agent was "http://download.newrelic.com/python_agent/beta/newrelic-python-0.5.17.47.tar.gz", however this didn't appear to exist yet (confusing because I had already downloaded it).  With a few curls, I was able to find the version listed above and carried on merrily.
</p>

<p>Per the Install file, the next step was to create a newrelic.ini file.  I copied the example file from software bundle into the root of my project.  Again per the instructions, I added my settings for license_key, app_name, and log file location.
</p>

<p>
The final change I made was to my index.wsgi file.  Here I added the following lines:

<pre>
# configure new relic
import newrelic.agent #new
newrelic.agent.initialize('/path/to/blog/newrelic.ini')  #new

# wsgi
import django.core.handlers.wsgi # old
application = django.core.handlers.wsgi.WSGIHandler() #old
application = newrelic.agent.wsgi_application()(application) #new
</pre>

The values commented as old already existed in my WSGI.  Those listed where required to initialize and start the new_relic agent.  A restart of the application is now required.
</p>

<p>
   <p>Now what?  Start checking out the cool reports!  I've shown a few examples below. Depending on the current site traffic, there may not be any data.</p>

<iframe src="https://rpm.newrelic.com/public/charts/k2Ctyx7ZP2N" width="500" height="300" scrolling="no" frameborder="no"></iframe>

<iframe src="https://rpm.newrelic.com/public/charts/7H7hpcDRU3n" width="500" height="300" scrolling="no" frameborder="no"></iframe>

<iframe src="https://rpm.newrelic.com/public/charts/9pgfWxGR3fN" width="500" height="300" scrolling="no" frameborder="no"></iframe>

