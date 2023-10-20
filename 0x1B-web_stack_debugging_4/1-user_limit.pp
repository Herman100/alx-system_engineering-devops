#  fixing error on user holberton login too many files
class ulimit {
  file { '/etc/security/limits.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "holberton soft nofile 4096\nholberton hard nofile 10240",
  }
}
include ulimit
