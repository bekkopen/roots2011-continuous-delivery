import "classes/*"
import 'nodes'

Exec {
  path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin'
}

File {
  mode   => '0644',
  owner  => 'root',
  group  => 'root',
}
