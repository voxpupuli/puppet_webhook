!#/bin/sh

cd /app && bundle exec rake db:migrate && bundle exec puma config.ru
