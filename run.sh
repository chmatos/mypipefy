#!bin/bash

RAILS_ENV=production bundle exec rake db:migrate
bundle exec puma -C config/puma.rb -e production

