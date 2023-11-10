---
layout: post
title: "My Notes On Uploading a Package PyPI"
date: "2012-04-12"
comments: true
tags: ["PyPI","python","opensource"]
---
<p>These are my notes for uploading to Pypi. Additionally, I've included some useful links that provide a lot of background.</p>
<!-- more -->
<p><a target='_tab' href='http://diveintopython3.ep.io/packaging.html' >http://diveintopython3.ep.io/packaging.html</a></p>
<p><a target='_tab' href='http://wiki.python.org/moin/CheeseShopTutorial'>http://wiki.python.org/moin/CheeseShopTutorial</a></p>
<p><a target='_tab' href='http://packages.python.org/an_example_pypi_project/setuptools.html'>http://packages.python.org/an_example_pypi_project/setuptools.html</a></p>

<ol>
    <li><p>Register at PyPI</p>
           <p>You can do so here: <a target='_tab' href='http://pypi.python.org/pypi?%3Aaction=register_form'>Register at PyPI</a></p>
    </li>
    <li><p>create a .pypirc file in your home directory</p>
    <pre>
    vi .pypirc

    [distutils]
    index-servers = pypi

    [pypi]
    username: &#060; username &#062;
    password: &#060; password &#062;
    </pre>
    </li>
    <li><p>upload your package to PyPI</p>
    <pre>
    cd  &#060; package root &#062;
    python setup.py register sdist upload
    </pre>
    </li>
</ol>
