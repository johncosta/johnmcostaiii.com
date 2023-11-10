---
layout: post
title: "My experience with python-gnupg"
date: "2011-09-09"
comments: true
tags: ["python-gnupg"]
---
<p>I was working though some usage of python-gnupg with a co-worker and, in the hope of helping out others (or my future self), am posting my shell and bpython notes here.  As time permits, I'll clean up the notes.</p>

<!-- more -->

<p>I've broken out my notes into 4 parts:</p>
<ol>
    <li>Manual Key Creation</li>
    <li>Sample File Creation</li>
    <li>Checking your keys & Writing your file</li>
    <li>Validating that it works</li>
</ol>

<h2>Manual Key Creation</h2>

<p>I created some keys manually with gpg so that I would have a baseline to work with.  If you don't have gpg installed, you can get it <a href="http://www.gpgtools.org/installer/index.html" target="_tab">here</a></p>

<p>Once you have gpg installed, you can now start the process of generating your public key.  Kick off the gpg generate key command. For my use, the default selections where good enough.</p>

<p>
<pre>
Johns-MacBook-Air:~ jcosta$ gpg --gen-key
gpg (GnuPG/MacGPG2) 2.0.17; Copyright (C) 2011 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Please select what kind of key you want\:

    (1) RSA and RSA (default)
    (2) DSA and Elgamal
    (3) DSA (sign only)
    (4) RSA (sign only)

Your selection? 1
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 2048
Requested keysize is 2048 bits
Please specify how long the key should be valid.

    0 = key does not expire
    <n>  = key expires in n days
    <n>w = key expires in n weeks
    <n>m = key expires in n months
    <n>y = key expires in n years

Key is valid for? (0)
Key does not expire at all
Is this correct? (y/N) y
GnuPG needs to construct a user ID to identify your key.
Real name: John Costa
Email address: john.costa@gmail.com
Comment:
You selected this USER-ID:
    "John Costa <john.costa@gmail.com>"
Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
You need a Passphrase to protect your secret key.
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: /Users/jcosta/.gnupg/trustdb.gpg: trustdb created
gpg: key 6FE30238 marked as ultimately trusted
public and secret key created and signed.
gpg: checking the trustdb

</pre>
</p>

<h2>Sample File Creation</h2>

<p>When attempting automation, I usually try to validate that I can complete the steps manually.  In this case, to validate
that encryption/decryption is working, and that I haven't botched key creation, I created a sample file called "test.txt".
I have placed a bit of text in the file which can be double checked when decrypted.</p>

<pre>
Johns-MacBook-Air:Documents jcosta$ echo "test" > test.txt
Johns-MacBook-Air:Documents jcosta$ cat test.txt
test
</pre>

<p>Before encrypting the file, it will be useful to know the id of the key just installed.  Use the "list keys" function
to display your keys.</p>

<pre>
Johns-MacBook-Air:Documents jcosta$ gpg --list-keys
/Users/jcosta/.gnupg/pubring.gpg
--------------------------------
pub   2048R/C4ECDCDC 2011-09-09
uid                  John Costa <john.costa@gmail.com>
sub   2048R/8149FB83 2011-09-09
</pre>

<p>Now encrypt the file, outputting the encrypted file as "test.gpg".  Use the public key id listed to encrypt the file.</p>

<pre>
Johns-MacBook-Air:Documents jcosta$ gpg --output test.gpg --armor --encrypt test.txt
You did not specify a user ID. (you may use "-r")

Current recipients:

Enter the user ID.  End with an empty line: John Costa <john.costa@gmail.com>

Current recipients:
2048R/8149FB83 2011-09-09 "John Costa <john.costa@gmail.com>"

Enter the user ID.  End with an empty line:
Johns-MacBook-Air:Documents jcosta$ ls -ltr
-rw-r--r--  1 jcosta  staff    5 Sep 13 06:01 test.txt
-rw-r--r--  1 jcosta  staff  609 Sep 13 06:32 test.gpg
</pre>

<p>Now that we've encrypted a file, lets decrypt the file!</p>

<pre>
Johns-MacBook-Air:Documents jcosta$ gpg --armor --output decrypt.txt --decrypt test.gpg

You need a passphrase to unlock the secret key for
user: "John Costa <john.costa@gmail.com>"
2048-bit RSA key, ID 8149FB83, created 2011-09-09 (main key ID C4ECDCDC)

gpg: encrypted with 2048-bit RSA key, ID 8149FB83, created 2011-09-09
      "John Costa <john.costa@gmail.com>"
Johns-MacBook-Air:Documents jcosta$ ls -ltr
total 24
-rw-r--r--  1 jcosta  staff    5 Sep 13 06:01 test.txt
-rw-r--r--  1 jcosta  staff  609 Sep 13 06:32 test.gpg
-rw-r--r--  1 jcosta  staff    5 Sep 13 06:42 decrypt.txt
Johns-MacBook-Air:Documents jcosta$ cat decrypt.txt
test
</pre>

======================================
Checking your keys & Writing your file
======================================

I then fired up a bpython session:

 | Johns-MacBook-Air:~ jcosta$ workon example-gpg
 | (example-gpg)Johns-MacBook-Air:~ jcosta$ bpython

 | >>> import gnupg
 | >>> gpg = gnupg.GPG(gnupghome="/Users/jcosta/.gnupg")
 | >>> gpg.list_keys()
 | [{'dummy': u'', 'keyid': u'059FF24CC4ECDCDC', 'expires': u'', 'length': u'2048', 'ownertrust': u'u', 'algo': u'1', 'fingerprint': u'0F379C3E410B6924C2502E26059FF24CC4ECDCDC', 'date': u'1315609511', 'trust': u'u', 'type': u'pub', 'uids': [u'John Costa <john.costa@gmail.com>']}]
 | >>> stream = open('/Users/jcosta/Documents/test.txt', "rb")
 | >>> encrypted_ascii_data = gpg.encrypt_file(stream, "059FF24CC4ECDCDC")
 | >>> encrypted_ascii_data.status
 | 'encryption ok'

 | >>> encrypted_ascii_data.data
 | '-----BEGIN PGP MESSAGE-----\\nVersion: GnuPG/MacGPG2 v2.0.17 (Darwin)\\nComment:
 | GPGTools -  | http://gpgtools.org\\n\\nhQEMAxqnnNGBSfuDAQf/est1PAn3sI4ZhPTHmcVe80wKlIcSu6N9
 | BZqPykkBso9S\\nfHGkcljtdJ0ICs3W38gn0qLG88UqzjNKWWCIgedAO0Pe12v38c8Ro3kN
 | SpJ+2hgo\\nWUpn1JxuunThHyfDK8UxmNXperlO1PjKhMlFsQwSFWHhC5u7CH4/hCaVN
 | KOKQc0K\\nkktXyoXM1D/CM1vlYCqDRbWyBdLg/W8VEOFy6zZHunDo4YxEWDmLE
 | EKj9kbdGTkq\\ndsEL6/Y6Zykx17RMonGVCZU1X7DEyLUCuVfDGCHrlSFi8NjxFR1CB
 | POhJWNadzlG\\nh7L8PJnWjcb/T2Mko5ZP5XWl4qN8hZljyg45x0PGzNI7AZLLnIOyzAt3T
 | AcyFZaJ\\nhq8qxoJAvJ7tNjt4BCb1hXOav/hJ64Xyp7IpgTL1PUiC9hK7nCYwBvv3QUg=
 | \\n=Vc4H\\n-----END PGP MESSAGE-----\n'
 | >>> out.write(encrypted_ascii_data.data)
 | >>> out.close()

The files aren't exactly the same size, but they should be close.

 | Johns-MacBook-Air:Documents jcosta$ ls -ltr
 | -rw-r--r--  1 jcosta  staff   15 Sep  9 15:02 test.txt
 | -rw-r--r--  1 jcosta  staff  592 Sep  9 16:28 test.py.gpg
 | -rw-r--r--  1 jcosta  staff  609 Sep  9 16:33 test.gpg


<h2>Handy References</h2>
<ul>
    <li><a href="http://www.gnupg.org/gph/en/manual.html">The GNU Privacy Handbook</a></li>
    <li><a href="http://en.wikipedia.org/wiki/RSA">RSA Encryption</a></li>
    <li><a href="http://en.wikipedia.org/wiki/Digital_Signature_Algorithm">DSA Encryption</a></li>
    <li><a href="http://en.wikipedia.org/wiki/ElGamal_signature_scheme">Elgamal encryption</a></li>
</ul>
