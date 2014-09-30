#!/usr/bin/env bash

apt-get update
sudo apt-get install -y curl
sudo apt-get install -y git
sudo apt-get install -y libpq-dev
sudo apt-get install -y nodejs
sudo apt-get install -y postgresql

# ruby
\curl -sSL https://get.rvm.io | bash -s stable
source /home/vagrant/.rvm/scripts/rvm
rvm install 2.1.1
rvm use 2.1.1

# rails
gem install bundler
cd /vagrant/
bundle
bin/rake s
