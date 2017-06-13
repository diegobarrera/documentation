#!/bin/bash

# nginx configuration file needed in the first command
#upstream app {
    # Path to Puma SOCK file, as defined previously
#    server unix:/home/ubuntu/payment_module/shared/sockets/puma.sock fail_timeout=0;
#}
#server {
#    listen 80;
#    server_name localhost;
#    root /home/ubuntu/payment_module/public;
#    try_files $uri/index.html $uri @app;
#    location @app {
#        proxy_pass http://app;
#        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#        proxy_set_header Host $http_host;
#        proxy_redirect off;
#    }
#    error_page 500 502 503 504 /500.html;
#    client_max_body_size 4G;
#    keepalive_timeout 10;
#}


sudo cp /home/ubuntu/payment_module/scripts/default /etc/nginx/sites-available/default
sudo /usr/sbin/service nginx restart
cd /home/ubuntu/payment_module/
bundle install
bundle exe rake assets:precompile

cd /home/ubuntu/payment_module/
pumactl stop
mkdir -p shared/pids shared/sockets shared/log
export RAILS_ENV="production"
puma -C config/puma.rb config.ru -d

