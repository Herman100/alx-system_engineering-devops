#Fixing the nginx by increasing the process handling
exec { 'process-scaling':
  command => "sed -i 's/worker_processes 5;/worker_processes 10;/g' /etc/nginx/nginx.conf; sudo service nginx restart",
  path    => ['/bin', '/usr/bin', '/usr/sbin']
}
