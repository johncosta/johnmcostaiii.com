---
layout: post
title: "Installing Redis on Docker"
date: "2013-04-07"
comments: true
tags: ["docker","dotCloud","redis","install","container","redis-on-docker","redis-on-dotcloud","private","PaaS","LXC"]
---

I'm currently employed by [dotCloud][6] and had an opportunity to play
around with our open sourced linux container runtime project called
[Docker][4].

You'll need to have an functional version of [docker][4] to follow these steps.
I've included an overview of my notes for installation, however you can find
additional [installation instructions][0] at the docker website.

<!-- more -->

## Introduction to Docker

If you've already worked with [docker][4], you can skip this part.  You already
have [docker][4] installed and probably are running your own containers.  If you
haven't, here's a general overview to a handful of [docker][4] commands. Please
read on.

I'm working on a MBA, so I ran through the [MacOS instructions][1] which are
repeated below.  It will require that you already have VirtualBox and Vagrant
already installed.  If you don't have these, you can find the getting
[started docs here][3].

First clone the repo and cd into the cloned repository:

`$ git clone https://github.com/dotcloud/docker.git && cd docker`

Now, a quick vagrant up and vagrant ssh and I was already issuing [docker][4]
commands.

Also note: I've  intentionally left out the vagrant output as there's nothing
too important there. It took about 1 minute to complete.

```
$ vagrant up
$ vagrant ssh

vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ docker ps
ID          IMAGE       COMMAND     CREATED     STATUS      COMMENT

vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ docker images
REPOSITORY          TAG                 ID                  CREATED             PARENT

vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ docker version
Version:0.1.2
Git Commit:
```

So far so good! Now lets run a shell within a [docker][4] container.

```
docker run -i -t base /bin/bash
Image base not found, trying to pull it from registry.
Pulling repository base
Pulling tag base:ubuntu-quantl
Pulling b750fe79269d2ec9a3c593ef05b4332b1d1a02a62b4accb2c21d589ff2f5f2dc metadata
Pulling b750fe79269d2ec9a3c593ef05b4332b1d1a02a62b4accb2c21d589ff2f5f2dc fs layer
10240/10240 (100%)
Pulling 27cf784147099545 metadata
Pulling 27cf784147099545 fs layer
94863360/94863360 (100%)
Pulling tag base:latest
Pulling tag base:ubuntu-12.10
Pulling tag base:ubuntu-quantal
```

So, what have we done here? We've called [run][2], which runs our command in a
new container, and passed a few [docker][4] specific parameters. These include, -i,
to keep stdin open, and -t to allocate a pseudo-tty. And finally the command
we're running is /bin/bash to give us a bash shell.

An interesting side effect is that we now have a [docker][4] base image locally.  We
can see this when we run `docker images`.

```
$ docker images
REPOSITORY          TAG                 ID                  CREATED             PARENT
base                latest              b750fe79269d        12 days ago         27cf78414709
base                ubuntu-12.10        b750fe79269d        12 days ago         27cf78414709
base                ubuntu-quantal      b750fe79269d        12 days ago         27cf78414709
base                ubuntu-quantl       b750fe79269d        12 days ago         27cf78414709
<none>              <none>              27cf78414709        12 days ago
```

Lastly, lets exit out of our [docker][4] container, <ctl-c> and you should see the
following:

```
SIGINT received
```

Let's check the status of our [docker][4] container:

```
vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ docker ps
ID             IMAGE         COMMAND      CREATED          STATUS          COMMENT
9468f9c097f7   base:latest   /bin/bash    25 minutes ago   Up 25 minutes
```

It looks like its still running...ok lets stop it:

```
vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ docker stop 9468f9c097f7
9468f9c097f7
```

Let's make sure that it's really gone:

```
$ docker ps
ID          IMAGE       COMMAND     CREATED     STATUS      COMMENT
```

## Installing and running Redis within a docker container

Now that we have a notion of what going on with docker commands and
installation, lets start loading it up with the tools we'll need for running a
[redis][5] server within a docker container.


Start up a new container using the base image.

```
$ docker run -i -t base /bin/bash
root@b9859484e68f:/#
```

Lets update our system packages from what's included in our base image:

```
root@b9859484e68f:/# apt-get update
Ign http://archive.ubuntu.com quantal InRelease
Hit http://archive.ubuntu.com quantal Release.gpg
Hit http://archive.ubuntu.com quantal Release
Hit http://archive.ubuntu.com quantal/main amd64 Packages
Get:1 http://archive.ubuntu.com quantal/universe amd64 Packages [5274 kB]
Get:2 http://archive.ubuntu.com quantal/multiverse amd64 Packages [131 kB]
Get:3 http://archive.ubuntu.com quantal/main Translation-en [660 kB]
Get:4 http://archive.ubuntu.com quantal/multiverse Translation-en [100 kB]
Get:5 http://archive.ubuntu.com quantal/universe Translation-en [3648 kB]
Fetched 9813 kB in 17s (557 kB/s)
Reading package lists... Done
root@b9859484e68f:/#
```

Now install telnet and our redis-server:

```
root@b9859484e68f:/# apt-get install telnet redis-server
Reading package lists... Done
Building dependency tree... Done
The following extra packages will be installed:
  libidn11 libjemalloc1
The following NEW packages will be installed:
  libidn11 libjemalloc1 redis-server telnet wget
0 upgraded, 5 newly installed, 0 to remove and 0 not upgraded.
Need to get 784 kB of archives.
After this operation, 1968 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu/ quantal/main libidn11 amd64 1.25-2 [119 kB]
Get:2 http://archive.ubuntu.com/ubuntu/ quantal/universe libjemalloc1 amd64 3.0.0-3 [85.9 kB]
Get:3 http://archive.ubuntu.com/ubuntu/ quantal/main telnet amd64 0.17-36build2 [67.1 kB]
Get:4 http://archive.ubuntu.com/ubuntu/ quantal/main wget amd64 1.13.4-3ubuntu1 [280 kB]
Get:5 http://archive.ubuntu.com/ubuntu/ quantal/universe redis-server amd64 2:2.4.15-1 [233 kB]
Fetched 784 kB in 2s (334 kB/s)
dpkg-preconfigure: unable to re-open stdin: No such file or directory
Selecting previously unselected package libidn11:amd64.
(Reading database ... 9893 files and directories currently installed.)
Unpacking libidn11:amd64 (from .../libidn11_1.25-2_amd64.deb) ...
Selecting previously unselected package libjemalloc1.
Unpacking libjemalloc1 (from .../libjemalloc1_3.0.0-3_amd64.deb) ...
Selecting previously unselected package telnet.
Unpacking telnet (from .../telnet_0.17-36build2_amd64.deb) ...
Selecting previously unselected package wget.
Unpacking wget (from .../wget_1.13.4-3ubuntu1_amd64.deb) ...
Selecting previously unselected package redis-server.
Unpacking redis-server (from .../redis-server_2%3a2.4.15-1_amd64.deb) ...
Processing triggers for ureadahead ...
Setting up libidn11:amd64 (1.25-2) ...
Setting up libjemalloc1 (3.0.0-3) ...
Setting up telnet (0.17-36build2) ...
update-alternatives: using /usr/bin/telnet.netkit to provide /usr/bin/telnet (telnet) in auto mode
Setting up wget (1.13.4-3ubuntu1) ...
Setting up redis-server (2:2.4.15-1) ...
Starting redis-server: redis-server.
Processing triggers for libc-bin ...
ldconfig deferred processing now taking place
Processing triggers for ureadahead ...
```

A quick double check to make sure that our redis-server is now installed:

```
root@b9859484e68f:/# which redis-server
/usr/bin/redis-server

root@b9859484e68f:/# redis-server --version
Redis server version 2.4.15 (00000000:0)
```

The image that we've created is clean and I want to keep this image before I
go much further, so now I'm going to open up another terminal and get back
to our vagrant image.  Here we can commit and store the filesystem state.

```
$ docker login
Username (): johncosta
Password:
Email (): john.costa@gmail.com
Login Succeeded

$ docker commit b9859484e68f johncosta/redis

$ docker push johncosta/redis
Pushing repository johncosta/redis (1 tags)
Pushing tag johncosta/redis:latest
Pushing 3e7b84670ea1c7d4b5df8095a3f2051ac2fb4e34fed101d553ad919c4bd923e4 metadata
Pushing 3e7b84670ea1c7d4b5df8095a3f2051ac2fb4e34fed101d553ad919c4bd923e4 fs layer
21975040/21975040 (100%)
Pushing b750fe79269d2ec9a3c593ef05b4332b1d1a02a62b4accb2c21d589ff2f5f2dc metadata
Pushing 27cf784147099545 metadata
Registering tag johncosta/redis:latest
```

- - -
#### Update:
I forgot to capture the commit command when grabbing the terminal output.  Not
to worry! I was able ssh into my vagrant VM and check the dockerd logs using:
`vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ less /var/log/dockerd`
- - -

Let's check what we've done and exit out of our container:

```
root@b9859484e68f:/# exit
exit
```

It looks like our docker container isn't running anymore!

```
$ docker ps
ID          IMAGE       COMMAND     CREATED     STATUS      COMMENT
```

Lets start up a new container, but this time use the image we just created and
committed to providing my redis instance as the image to use.

`docker run -i -t johncosta/redis /bin/bash`

```
vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ docker run -i -t johncosta/redis /bin/bash


root@61507c28cd67:/# /etc/init.d/redis-server start
Starting redis-server: redis-server.
root@61507c28cd67:/# ps faux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.5  18068  2016 ?        S    15:58   0:00 /bin/bash
redis       14  0.0  0.4  36624  1656 ?        Ssl  16:01   0:00 /usr/bin/redis-
root        17  0.0  0.3  15524  1108 ?        R    16:01   0:00 ps faux
```


Let's make sure we can connect to it and interact with [redis][5] (remember we installed telnet!).

```
root@61507c28cd67:/# telnet 127.0.0.1 6379
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
+OK
+1365177842.076283 "MONITOR"
+OK
+1365177870.147208 "set" "docker" "awesome"
$7
awesome
+1365177874.927280 "get" "docker"
+OK
Connection closed by foreign host.
```

Ok, we know we can connect to [redis][5] and interact with it.  But we're inside
the container, lets see how to connect to it from outside the container!
First, lets inspect our container:

```
$ docker inspect 61507c28cd67
{
   "Id": "61507c28cd673ea4464248a8c2b936807bf951d6dc82d0f872b02586c5681139",
   "Created": "2013-04-05T08:58:33.711054-07:00",
   "Path": "/bin/bash",
   "Args": [],
   "Config": {
       "Hostname": "61507c28cd67",
       "User": "",
       "Memory": 0,
       "MemorySwap": 0,
       "AttachStdin": true,
       "AttachStdout": true,
       "AttachStderr": true,
       "Ports": null,
       "Tty": true,
       "OpenStdin": true,
       "StdinOnce": true,
       "Env": null,
       "Cmd": [
           "/bin/bash"
       ],
       "Image": "johncosta/redis"
   },
   "State": {
       "Running": true,
       "Pid": 6052,
       "ExitCode": 0,
       "StartedAt": "2013-04-05T09:09:19.733633-07:00"
   },
   "Image": "3e7b84670ea1c7d4b5df8095a3f2051ac2fb4e34fed101d553ad919c4bd923e4",
   "NetworkSettings": {
       "IpAddress": "10.0.3.8",
       "IpPrefixLen": 24,
       "Gateway": "10.0.3.1",
       "PortMapping": {}
   },
   "SysInitPath": "/opt/go/bin/docker"
}
```

Hmm, It looks like we don't have a port that we can connect to. Looking at the
run command, there's something that we missed, the `-p` option, map a network
port to the container.  Let's try this with the following:

`docker run -p 6379 -i -t johncosta/redis /usr/bin/redis-server`

Much better, we can now see that we've allocated ports 6379 and mapped it to
the external port 49153.

```
vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ docker ps
ID             IMAGE                    COMMAND      CREATED         STATUS         COMMENT
0be92ce8581e   johncosta/redis:latest   /bin/bash    3 minutes ago   Up 3 minutes
vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ $ docker port 0be92ce8581e 6379
49153
```

Note: We don't need to inspect the container and parse the entire container
information set to get the mapped port. We can use the convenience command
`docker port`.

OK! We're almost there.  Now terminate that docker process and start with a new
command to start our redis server within docker in daemon mode.   Test the
results with a telnet session and a redis-cli session external to the docker
container.

`docker run -d -p 6379 -i -t johncosta/redis /usr/bin/redis-server`

```
vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ docker ps
ID             IMAGE                    COMMAND                CREATED         STATUS         COMMENT
c0f7e48cafcf   johncosta/redis:latest   /usr/bin/redis-serve   4 minutes ago   Up 4 minutes
vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ docker port c0f7e48cafcf 6379
49174

vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ telnet 10.0.3.30 49174
Trying 10.0.3.30...
Connected to 10.0.3.30.
Escape character is '^]'.
monitor
+OK
+1365194060.897490 "monitor"
set docker awesome
+OK
+1365194071.640199 "set" "docker" "awesome"
get docker
$7
awesome
+1365194073.519484 "get" "docker"
quit
+OK
Connection closed by foreign host.

vagrant@vagrant-ubuntu-12:/opt/go/src/github.com/dotcloud/docker$ redis-cli -h 10.0.3.30 -p 49174
redis 10.0.3.30:49174> get docker
"awesome"

```

- - -
#### Update 5/6/2013:
It's now possible to save images with their configuration options! I added one
additional commit to do this:

`docker commit -run '{"Cmd": ["/usr/bin/redis-server"], "PortSpecs": [":6379"]}' b9859484e68f johncosta/redis`

Now to run an image it's as easy as:

Get the image:
`docker pull johncosta/redis`

Run the image:
`docker run johncosta/redis`

Run in daemon mode:
`docker run -d johncosta/redis`

Also, Check out the [docker index][7].
- - -

la fin


[0]: http://docs.docker.io/en/latest/installation/
[1]: http://docs.docker.io/en/latest/installation/macos/
[2]: http://docs.docker.io/en/latest/commandline/command/run/
[3]: http://docs-v1.vagrantup.com/v1/docs/getting-started/
[4]: http://docker.io
[5]: http://redis.io
[6]: http://dotcloud.com
[7]: http://index.docker.io
