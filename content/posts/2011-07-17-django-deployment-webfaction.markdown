---
layout: post
title: "Django Deployment on Webfaction"
date: "2011-07-17"
comments: true
tags: ["BitBucket","deployment","django","documentation","opensource","python","Webfaction"]
---
<p>Recently I deployed a django application to WebFaction (this blog!).  While this wasn't the first app I've deployed there, I did forget a few steps along the way which required a bit of research and experimentation on my part.  To avoid this in the future, I've documented the steps I took to deploy the app here.</p>

<!-- more -->

<p>I'm going to assume that you have a django app working for you locally.  If you don't have one, feel free to use this <a href='https://bitbucket.org/jcosta71/example-webfaction-deploy' target='_tab'>sample project</a> available for download in bitbucket. </p>

<p><a href='http://www.webfaction.com/signup?affiliate=johncosta' target='_tab'><img src='/images/django_webfaction/webfaction-240x60-django-rails-wp.png' /></a></p>

<h3>Webfaction Control Panel</h3>
<ol>
<li><p>After logging into the WebFaction control panel, find the Domains/websites link.  Clicking on it opens up another list underneath.  Click Applications.  Create a new application by clicking the small icon on the bottom right of the screen.</p>
<p><a href='/images/django_webfaction/wf_create_app.png'><img src="/images/django_webfaction/wf_create_app.png" alt="create_wf_app" height='225px' width='500px' /></a></p>
</li>

<li><p>Name your application.  The name is going to be the app name on the sever, so make sure that it's unix compliant.  My preference is to replace spaces/dashes with underscores and lowercase everything.  So "Example Blog" becomes "example_blog".  The page form will validate this so that no errors are made in naming convention.</p>
<p><a href='/images/django_webfaction/wf_name_app.png'><img src="/images/django_webfaction/wf_name_app.png" alt="wf_name_app" height='225px' width='500px' /></a></p>
</li>

<li><p>Next, you'll choose the type of application you'd like to deploy.  Choose the App category as Django.  Next choose the App type. There are quite a few options available, some with differing versions of python. Some are listed as as insecure and shouldn't be used (unless you have a really good reason and know what you are doing).  My preference is to use the latest and greatest django/python versions for new applications.</p>
<p><a href='/images/django_webfaction/wf_categories_app.png'><img src="/images/django_webfaction/wf_categories_app.png" alt="wf_catagories_app" height='400px' width='500px' /></a></p>
</li>

<li><p>Once you hit create, WebFaction will create the environment on their servers so that you can deploy your application.  This includes python, django, and apache pre-configured to work out of the box.</p>
<p><a href='/images/django_webfaction/wf_cat_selected.png'><img src="/images/django_webfaction/wf_cat_selected.png" alt="wf_catagories_app" height='400px' width='500px' /></a></p>
</li>

<h3>Deploying your application</h3>
<li>Do this by cloning your project into a location on the WebFaction server. WebFactions default is to place the project under the ~/webapps/<blog name>. I find this long path cumbersome and usually just use my home directory.      One thing I recommend is creating a symlink linking to the project.  Use this symlink for any path references.  This way if you want to iterate versions of code by checking out a specific tags, you need only to change the symlink.

```
cd ~
hg clone ssh://hg@bitbucket.org/jcosta71/example-webfaction-deploy example_project
ln -s example_project example
```

</li>

<li>Apache and mod_wsgi configuration.  WebFaction creates a default apache2 configuration file and project wsgi file.  For the sake of this example, I've pulled them into the example project.  All that should be required is to correct the pathing in these two files, create symlinks to the appropriate locations, and restart apache.

```
cd ~/webapps/example_application
ln -s ~/example/apache/conf/example.wsgi example.wsgi
cd ~/webapps/example_application/apache2/conf
mv httpd.conf httpd.conf.bak
ln -s ~/example/apache/conf/httpd.conf httpd.conf
```

Because of my preference to checkout the applications into the root. I've tweeked the wsgi and httpd.conf files slightly.  The changes include:<br />

example.wsgi:<br />

From:
```
os.environ['DJANGO_SETTINGS_MODULE'] = 'myproject.settings'
```

To:
```
os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'
```

httpd.conf:<br />

From:
```
WSGIPythonPath /home/johncosta/webapps/example_application:/home/johncosta/webapps/example_application/lib/python2.6
WSGIScriptAlias / /home/johncosta/webapps/example_application/myproject.wsgi
```
To:
```
WGIPythonPath /home/johncosta/example/sample_project/:/home/johncosta/webapps/example_application/lib/python2.6
WSGIScriptAlias / /home/johncosta/webapps/example_application/example.wsgi
```
</li>

<h3>Add the static files</h3>
<li><p>The next step is to generate and map the static files to your application.  Django has added in 1.3 static directory support.  See the documentation <a href='https://docs.djangoproject.com/en/1.3/ref/contrib/staticfiles/' target='_tag'>here</a>.  To map your static files to the application you'll first need to publish them in a known location.
<ol>
    <li>Set the STATIC_ROOT value in your local_settings.py file to the location you want all the static files collected to.</li>
    <li>Change your directory to the location of your manage.py file.</li>
    <li>Run the collect static management command. You may have to add django to your python path.</li>
</ol>

```
cd ~/example_project/sample_project</li>
PYTHONPATH=/home/johncosta/example/sample_project/:/home/johncosta/webapps/example_application/lib/python2.6/:$PYTHONPATH
python2.6 manage.py collectstatic
```
</p>
</li>

<li><p>Create a new application for your static content by going back into the WebFaction Control Panel.  Name your new application and select symbolic link for a category.  You'll use the default symbolic link to static/cgi/php app type.  In the extra info, enter the absolute path to the path you set your STATIC_ROOT.

```
/home/johncosta/example/sample_project/static_root
```

</p>
<p><a href='/images/django_webfaction/wf_create_static.png'><img src="/images/django_webfaction/wf_create_static.png" alt="wf_create_static" height='400px' width='500px' /></a></p>
</li>

<h3>It's alive!</h3>
<li><p>This last step maps your application and static content to a domain.  Log back into WebFaction control panel, choose Websites under Domains/websites.  I've already created a domain in the control panel that I'd like to map my application to.  Webfaction has a how-to guide on creating domains <a href='http://docs.webfaction.com/user-guide/domains.html' target='_tab'>here</a>. </p>

<p>I've chosen to name the example_projects as example.  Choose the subdomain for your application, and  map your site app (we call this example_application) to "/".  Map the static app (this was named example_application_static) to "/static".  This value should be the same value as STATIC_URL found in your local_settings.py file.</p>

<p><a href='/images/django_webfaction/wf_map_static.png'><img src="/images/django_webfaction/wf_map_static.png" alt="wf_map_static" height='400px' width='500px' /></a></p>

</li>

<li>You should now be able to access your domain!  Here's my example. <a href='http://example.johncosta.webfactional.com/' target='_tab'>http://example.johncosta.webfactional.com</a></li>

</ol>
