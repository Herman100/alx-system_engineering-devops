# Install Nginx
package { 'nginx':
  ensure => installed,
}

# Set the hostname as the value for the custom HTTP header "X-Served-By"
file_line { 'nginx_custom_header':
  path  => '/etc/nginx/sites-available/default',
  line  => "add_header X-Served-By ${hostname};",
  match => '^add_header X-Served-By',
}

# Restart Nginx to apply changes

service { 'nginx':
  ensure    => running,
  enable    => true,
  hasstatus => true,
  require   => Package['nginx'],
}
