---
layout: post
title: "Django view decorators"
date: "2013-02-20"
comments: true
tags: ["django","decorators","views","django-userena"]
---
I recently worked on a project that required a standard account and profile
system.  [django-userena][0] is usually my goto project for this due to its ease of
setting up and its extensibility. There's a subtle nuance to using this
project's default urls patterns in that the majority of the url patterns
require passing the user's username in the url.  The username is then used in
the view to find the user, since usernames are unique to the user.

<!-- more -->

For this particular project, I wanted to hide the username from the url path
and came up with the following decorator that would allow us to use all the
existing functionality of django-userena.

```
from functools import wraps

from django.core.urlresolvers import reverse
from django.conf import settings
from django.http import HttpResponseRedirect
from django.utils.decorators import available_attrs

LOGIN_URL = getattr(settings, 'LOGIN_URL')


def user_to_view(view_func):
    """ This view decorator is used to wrap views that require a user name,
    injecting the username, pulled from the request, into the view.
    """
    def _wrapped_view(request, *args, **kwargs):
        if not request or not request.user:
            return HttpResponseRedirect(reverse(LOGIN_URL))
        username = request.user.username
        kwargs.update(dict(username=username))
        return view_func(request, *args, **kwargs)
    return wraps(view_func, assigned=available_attrs(view_func))(_wrapped_view)

```

Now, for the each url pattern you want to modify, redefine it in your urls.py
file, wrapping the url you're looking to modify.
```
urlpatterns += patterns('',
    url(r'^edit/$', user_to_view(userena_views.profile_edit),
        {'edit_profile_form': ProfileFormExtra}, name='userena_profile_edit'),)
```

[0]: http://www.django-userena.org/
