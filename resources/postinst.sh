#!/usr/bin/env bash
export SINATRA_ENV=production
export RUBYLIB=/opt/voxpupuli/webhook/lib/ruby:/opt/voxpupuli/webhook
export GEM_HOME=/opt/voxpupuli/webhook/lib/ruby/gems/2.6.0
export GEM_PATH=$GEM_HOME
export LD_PATH=/opt/voxpupuli/webhook/lib
export PATH=/opt/voxpupuli/webhook/bin:$PATH

cd /opt/voxpupuli/webhook && bin/bundle install && bin/bundle exec rake db:migrate
