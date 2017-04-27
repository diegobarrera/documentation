#!/bin/bash
# install codedeploy dependecies
sudo apt-get -y update 
sudo apt-get -y install python-pip 
sudo apt-get -y install ruby 
sudo apt-get -y install wget 
cd /home/ubuntu 
wget https://aws-codedeploy-us-west-2.s3.amazonaws.com/latest/install 
chmod +x ./install 
sudo ./install auto 
sudo service codedeploy-agent start

# install Ruby and Bundler
# rails -v 4.2.6
# ruby -v 2.3.1
sudo apt-get update
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
cd	
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
rbenv install 2.3.1
rbenv global 2.3.1
ruby -v
gem install bundler

# install rails
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
gem install rails -v 4.2.6
rbenv rehash

# install PostgreSQL
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-common
sudo apt-get install -y postgresql-9.5 libpq-dev

# install nginx
sudo apt-get install -y nginx
sudo nano /etc/nginx/sites-available/default
######
sudo services nginx restart

# clone project
git clone https://github.com/mercadoni/payment_module.git
cd payment_module
bundle install
rake assets:precompile RAILS_ENV=test
puma -d

#config puma
mkdir -p shared/pids shared/sockets shared/log
