# Install Nginx
package { 'nginx':
  ensure => installed,
}

# Set the hostname as the value for the custom HTTP header "X-Served-By"
file_line { 'custom_header_line':
  ensure => present,
  path   => '/etc/nginx/nginx.conf',
  line   => "add_header X-Served-By ${hostname};",
  match  => '^add_header X-Served-By',
}

# Restart Nginx to apply changes
service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  subscribe  => File_line['custom_header_line'],
}
