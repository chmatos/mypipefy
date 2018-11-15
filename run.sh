#!bin/bash

RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake assets:precompile
bundle exec puma -C config/puma.rb -e production

