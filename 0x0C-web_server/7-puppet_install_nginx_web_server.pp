# nginx package installation w puppet

package { 'nginx':
  ensure => installed,
}

file { '/var/www/html/index.nginx-debian.html':
  ensure  => file,
  content => 'Hello World!',
  require => Package['nginx'],
}

file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => '
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name _;
    location / {
        try_files $uri $uri/ =404;
    }
    location = /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
}',
  require => Package['nginx'],
}

service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}
