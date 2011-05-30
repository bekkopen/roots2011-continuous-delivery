Basic Unix Automation Skills (SH+SSH)
=====================================

Really Simple. You come a very long way with basic commands:

    !sh
    ls, chmod, mkdir -p, rm -f, kill, ps, cut, grep, sed, awk & man

Remoting is also really simple using SSH.

    !sh
    ssh, scp, sftp, rsync

---

Unix Processes
==============

Simple to automate. Thats why I prefer deploying standalone applications.

Unix Signals
------------

Unix processes use signals to change between states. There are several signals available, some more important than others. For now, its enough to mention four:

    * SIGHUP - hangup (1)
    * SIGINT - interrupt (2)
    * SIGQUIT - quit (3)
    * SIGKILL - kill (9)
    * SIGTERM - terminate (15)

---

SSH Key-based auth
==================

    !sh
    ∴ ➜ ssh-keygen
    Generating public/private rsa key pair.
    Enter file in which to save the key (/Users/oc/.ssh/id_rsa):
    Enter passphrase (empty for no passphrase): **put smarties tubes on kitten legs**
    Enter same passphrase again: **put smarties tubes on kitten legs**
    Your identification has been saved in /Users/oc/.ssh/id_rsa.
    Your public key has been saved in /Users/oc/.ssh/id_rsa.pub.
    The key fingerprint is:
    83:bf:7e:69:aa:e5:d1:de:67:aa:63:92:94:d3:07:f1 oc@snappy.local
    The key's randomart image is:
    +--[ RSA 2048]----+
    |                 |
    |          .      |
    |           o     |
    |       .  . E    |
    |      . So .     |
    |       .+o. .    |
    |       .+o.o     |
    |       oo+*.  o  |
    |      .o=*ooo+   |
    +-----------------+

Change password:

    !sh
    ∴ ➜ ssh-keygen -p

---

Authorized Keys
===============

~/.ssh/authorized_keys is read by the sshd-server and grants access to clients based on their pubkey.

    !sh
    ∴ ➜ echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAmZW ... ium5OQ== oc@snappy" >> ~/.ssh/authorized_keys

Your public key:

    !sh
    ∴ ➜ cat ~/.ssh/id_rsa.pub
    ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAmZW ... ium5OQ== oc@snappy

---

Authorized Keys (cont.)
=======================

If you password protect your keys (as you should), use the ssh-agent to keep the authentication information in memory (so you do not have to retype your password)

    !sh
    ∴ ➜ eval `ssh-agent`

Add keys to the agent with:

    !sh
    ∴ ➜ ssh-add


---

.ssh/config
===========

    !sh
    Host node1
    HostName 178.79.164.192
    User roots

    Host node2
    HostName 178.79.164.194
    User roots

    Host mgmt
    HostName 178.79.166.113
    User oc

    Host cryptic
    HostName somehost
    User sdvxwksntw

---

init-scripts (/etc/init.d)
==========================

    !sh
    service <initscript> <cmd>

Common options (commands):

* start
* stop
* restart
* reload
* force-reload
* status


---

run-levels
==========

0. System halt
1. Single-user mode
2. Multiuser, without NFS
3. Complete multiuser mode
4. User defined
5. X11 (XDM login)
6. Reboot

---

Enabling Scripts
================

You enable init scripts by adding a runlevel, start and stop priorities in your init-script.

    !sh
    echo "# chkconfig: 2345 20 80" >> /etc/init.d/myapplication

You enable it (to run on 2345, etc) with chkconfig (update-rc.d on Debian).

    !sh
    chkconfig puppet on

    !sh
    chkconfig --list | grep puppet
    puppet         	0:off	1:off	2:on	3:on	4:on	5:on	6:off

---



