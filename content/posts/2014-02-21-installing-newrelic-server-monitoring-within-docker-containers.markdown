---
title: "Installing New Relic Server Monitoring within Docker Containers"
date: "2014-02-21"
comments: true
tags: ["newrelic","new relic","server","monitoring","docker","containers","error"]
---

The inspiration for this post is from a recent Stack Overflow question that I
had answered when I had found the selected answer could be improved upon. You
can find it [here][3].

I ran into a problem recently when working with [Docker][0] and [New Relic Server Monitoring][1] together.
Using the directions found in the [New Relic docs for Ubuntu/Debian][2], the Dockerfile additions I
first came up with looked as follows:

<!-- more -->

```
FROM stackbrew/ubuntu:12.04
MAINTAINER John Costa (john.costa@gmail.com)

RUN apt-get update
RUN apt-get -y install wget

# install new relic server monitoring
RUN echo deb http://apt.newrelic.com/debian/ newrelic non-free >> /etc/apt/sources.list.d/newrelic.list
RUN wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -
RUN apt-get update
RUN apt-get install newrelic-sysmond
RUN nrsysmond-config --set license_key=YOUR_LICENSE_KEY

CMD ["/etc/init.d/newrelic-sysmond", "start"]
```

This results in an error when trying to wget from download.newrelic.com:

```
--2014-02-21 23:19:33--  https://download.newrelic.com/548C16BF.gpg
Resolving download.newrelic.com (download.newrelic.com)... 50.31.164.159
Connecting to download.newrelic.com (download.newrelic.com)|50.31.164.159|:443... connected.
ERROR: cannot verify download.newrelic.com's certificate, issued by `/C=US/O=GeoTrust, Inc./CN=GeoTrust SSL CA':
  Unable to locally verify the issuer's authority.
To connect to download.newrelic.com insecurely, use `--no-check-certificate'.
gpg: no valid OpenPGP data found.
```

The error seems to present a solution that is tempting, especially because it works.  This
would be adding `--no-check-certificate` to your wget command.  This workaround does
avoid the error, but also works around the protection that ssl is providing.

The fix is really straight forward, but not obvious if you're not familiar with
apt.  With the installation of the `ca-certificates` package as part of your
dockerfile, you can use wget and still validate the certificate.


The following is a working sample:

```
FROM stackbrew/ubuntu:12.04
MAINTAINER John Costa (john.costa@gmail.com)

RUN apt-get update
RUN apt-get -y install ca-certificates wget  # <-- updated line

# install new relic server monitoring
RUN echo deb http://apt.newrelic.com/debian/ newrelic non-free >> /etc/apt/sources.list.d/newrelic.list
RUN wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -
RUN apt-get update
RUN apt-get install newrelic-sysmond
RUN nrsysmond-config --set license_key=YOUR_LICENSE_KEY

CMD ["/etc/init.d/newrelic-sysmond", "start"]
```

Some caveats:

* This container is really short lived and will exit almost immediately.  The
  example is for illustrative use.

* Don't forget to put your actual license key in place of "YOUR_LICENSE_KEY" or
  else you'll get an error of the following: `Error: invalid license key - must
  be 40 characters exactly`

* This is a working example, but I realize that most wont want to use the
  single `/etc/init.d/newrelic-sysmond start` command to run their container.
  you'll most likely have some sort of init.sh script and place this command
  in the init.sh.

* You might not want to install the server monitoring in your development
  environments.  To work around this, in the same init.sh script above, you
  could check for an environment variable that you inject when the container
  is first started.  Your init file might look as follows (including the start
  command):

```
# Conditionally install our key only in production and staging
if [ "${MY_ENV}" == "production" ] || [ "${MY_ENV}" == "staging" ] ; then
    nrsysmond-config --set license_key=YOUR_LICENSE_KEY
fi

# The New Relic daemon likes to manage itself. Start it here.
/etc/init.d/newrelic-sysmond start
```


[0]: http://docker.io
[1]: https://docs.newrelic.com/docs/server/new-relic-for-server-monitoring
[2]: http://docs.newrelic.com/docs/server/server-monitor-installation-ubuntu-and-debian
[3]: http://stackoverflow.com/questions/20909111/adding-gpg-key-inside-docker-container-causes-no-valid-openpgp-data-found/21921321#21921321
