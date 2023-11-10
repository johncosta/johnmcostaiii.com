---
layout: post
title: "Configuring an internal ReadTheDocs"
date: "2012-05-01"
comments: true
tags: ["readthedocs", "documentation"]
---
Project Overview
----------------
   * ReadTheDocs application to serve project documentation
   * Simple and Straightforward, minimal overhead
   * Modified to point to our domain, not readthedocs
   * Restricted Public Access
<!-- more -->

Technology Overview
-------------------
ReadTheDocs comes with the following technology stack:

   * Varnish
   * Nginx
   * gunicorn
   * postgres
   * python/django
   * solr (haystack search)
   * Chef

In an effort to align with some of the technologies I have some experience with, I modified the technology stack slightly, its now as follows:

    * supervisor
    * gunicorn
    * memcached
    * nginx
    * python/django
    * mysql
    * whoosh (haystack search)
    * fabric

Key Functionality Overview
--------------------------

   * Built and versioned documentation (http://50.57.69.212/)
   * Search

Setup Steps
-----------

Provision a server:
   * Provision an ubuntu 11.10 instance (I used rackspace, other versions have not been tested)

Clone and setup the project locally:
   * `git clone git@github.com:johncosta/readthedocs.org.git`
   * `mkvirtualenv --distribute readthedocs`
   * `pip install -r pip_requirements.txt`
   * modify the fabfile-ubuntu.py file by changing the server ip and root password to the values returned by your instance provisioner
   * run `fab -f fabfile-ubuntu.py stage_rtd`

Post Installation Steps:
   * Try http://50.57.69.212/
   * Change the root password to mysql!!
   * Change the `test` user password!!
   * Configure IP Tables to be as restrictive as you need
   * Enable email via django settings
   * Upload a test project (test/test)
   * Modify the nginx settings to support (project name).domain.com support: `http://50.57.69.212/docs/readthedocsexample/en/latest/py-modindex.html`

Some Gotcha's
-------------
   * If builds fail, information on why they fail is sparse
