#!/bin/bash

cd /app

bundle status || bundle install

bundle exec rake db:migrate &&
bundle exec puma config.ru
