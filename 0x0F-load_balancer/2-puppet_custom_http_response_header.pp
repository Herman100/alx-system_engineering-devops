# Install Nginx
package { 'nginx':
  ensure => installed,
}

# Set the hostname as the value for the custom HTTP header "X-Served-By"
exec { 'nginx_custom_header':
  command => "sed -i '16i\add_header X-Served-By ${hostname};' /etc/nginx/nginx.conf",
  unless  => "grep '^add_header X-Served-By' /etc/nginx/nginx.conf",
}

# Restart Nginx to apply changes
service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  subscribe  => Exec['nginx_custom_header'],
}
