Puppet
======

This is a drop-in replacement for puppet/puppetmaster.

It is mainly tweaked to fit with RHEL/CentOS installations, however some recipies should work with minor adjustments on Debian, Ubuntu, etc.

Install new node
================
Create configuration (see manifests/nodes.pp)
Run init-node.sh on new node
Sign (certificate of) the new node with puppetca.

<code>
  [root@mgmt site]# puppetca --sign node1.muda.no
  notice: Signed certificate request for node1.muda.no
  notice: Removing file Puppet::SSL::CertificateRequest node1.muda.no at '/var/lib/puppet/ssl/ca/requests/node1.muda.no.pem'
</code>

