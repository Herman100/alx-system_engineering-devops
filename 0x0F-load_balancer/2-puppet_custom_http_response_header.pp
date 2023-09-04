file { '/etc/nginx/nginx.conf':
  content => template('custom_http_response_header.conf.erb'),
}

template 'custom_http_response_header.conf.erb' {
  source => 'custom_http_response_header.conf.erb',
  variables => {
    hostname => $::hostname,
  },
}
