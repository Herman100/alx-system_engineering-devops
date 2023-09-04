# Install Nginx
package { 'nginx':
  ensure => present,
}

file { '/etc/nginx/nginx.conf':
  content => template('custom_http_response_header.conf.erb'),
}

template 'custom_http_response_header.conf.erb' {
  source => 'custom_http_response_header.conf.erb',
  variables => {
    hostname => $::hostname,
  },
}

service { 'nginx':
  ensure    => running,
  enable    => true,
  hasstatus => true,
  require   => Package['nginx'],
}
