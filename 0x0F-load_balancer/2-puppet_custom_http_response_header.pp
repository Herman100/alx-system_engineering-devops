# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Define a custom HTTP header
file { '/etc/nginx/conf.d/custom_header.conf':
  ensure  => file,
  content => "add_header X-Served-By $hostname;\n",
  notify  => Service['nginx'],
}

# Ensure Nginx service is running
service { 'nginx':
  ensure => 'running',
  enable => true,
}
