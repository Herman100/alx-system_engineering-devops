# Install Nginx
package { 'nginx':
  ensure => present,
}

# Start Nginx service
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

# Set the hostname as the value for the custom HTTP header "X-Served-By"
file_line { 'nginx_custom_header':
  path   => '/etc/nginx/nginx.conf',
  line   => "    add_header X-Served-By $::hostname;",
  match  => '^http {',
  after  => '^http {',
  notify => Service['nginx'],
}
