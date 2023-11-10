---
layout: post
title: "Django Projects to Django Apps: Converting the Unit Tests"
date: "2013-04-21"
comments: true
tags: ["django","py.test","pytest-django","configuration","installation"]
---

Recently I went through a process of breaking a large [django][0] project into
smaller installable applications.  Each smaller component could be reused from
within any number of django projects, but wasn't a [django][0] project
itself.  One of the issues I encountered was "What do I do with the unit
tests?"  Using the standard `./manage.py test` no longer worked for me because
my settings where in the master project.

I had heard of [py.test][1], so this seemed like an opportunity to see if some
of the py.test magic would work for me.  Admittedly, I didn't do a large amount
of searching around for additional testing frameworks or processes...this was
an excuse to try out the project. :)

<!-- more -->

### Installation ###
Installing [py.test][1] is easy.  Because I wanted some additional features
(DJANGO_SETTINGS_MODULE environment variable specifically), so I opted for the
[pytest-django][2] module instead of the base pytest project.
```
pip install pytest-django
```

### Configuration ###
To get my unit tests running, I needed to add a few additional things:

* a test settings file
* a conftest.py file
* a pytest.ini file
* a small amount of test package cleanup

#### test settings file ####
Created a very light settings file with only my database configuration
```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': ':memory:',
        }
}
```

#### conftest.py ####
This was required to [fix an issue with my settings file location][3].
```
  import os
  import sys

  sys.path.append(os.path.dirname(__file__))
```

#### pytest.ini file ####
As a convenience, instead of passing parameters on the commandline each time,
py.test uses a pytest.ini file to pass these arguments to the test runner.
```
[pytest]
DJANGO_SETTINGS_MODULE = tests.pytest_settings
```

#### test package cleanup ####
py.test has [smarter test resolution][4]. To take advantage of these features, I did
the following:

* Removed statements like `from mytests import *` from the `__init__.py` files
* Changed the name of my tests to match test* format

### Wrap-up ###

Hopefully this post helps future me and others to quickly get up and running
with [py.test][1] and [pytest-django][2].

[0]: https://www.djangoproject.com/
[1]: http://pytest.org/latest/
[2]: http://pytest-django.readthedocs.org/en/latest/configuring_django.html
[3]: http://stackoverflow.com/questions/15199700/django-py-test-does-not-find-settings-module
[4]: http://pytest.org/latest/example/pythoncollection.html
