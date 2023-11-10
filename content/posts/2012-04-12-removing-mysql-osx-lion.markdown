---
layout: post
title: "Removing MySQL from OSX Lion"
date: "2011-08-28"
comments: true
tags: ["MySQL","OSX","Lion"]
---
Recently I've had to remove a version of MySQL 5.5 from my Macbook so that I could go back to a 5.1 version.  However it appears that there isn't an automatic way to remove and install an older version.  A few google searches revealed a bulk of the removal process, but additional searching revealed a few more steps.

<!-- more -->

```
sudo rm /usr/local/mysql
sudo rm -rf /usr/local/mysql*
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/My*
rm -rf ~/Library/PreferencePanes/My*
sudo rm -rf /Library/Receipts/mysql*
sudo rm -rf /Library/Receipts/MySQL*
sudo rm -rf /var/db/receipts/com.mysql.*

# Edit the following file, removing the line `MYSQLCOM=-YES-`.
# you may need sudo for write privileges to edit the file
# TIP: when using vim, use `dd` to delete the line and then `:wq` to save
#      the file
sudo vim /etc/hostconfig   # remove the line MYSQLCOM=-YES-
```

9/28/2011 - added comment on last line.  Thanks Justin for pointing this out! </br>
8/16/2013 - removed html line breaks.  Added additional notes on vim from Tom Jacobs. Thanks!

<p>
Web references:

<ul>
<li>
<a href='http://stackoverflow.com/questions/1436425/how-do-you-uninstall-mysql-from-mac-os-x'>http://stackoverflow.com/questions/1436425/how-do-you-uninstall-mysql-from-mac-os-x<a></li>
<li>http://akrabat.com/computing/uninstalling-mysql-on-mac-os-x-leopard/</li>
</ul>
</p>
