FROM ruby:2.4.2-slim

# Installation of dependencies
RUN apt-get update -qq \
  && apt-get install -y \
    build-essential \
    libpq-dev \
    vim \
    curl \
    apt-transport-https \
    libmysqlclient-dev \
    sudo \

    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \

    && apt-get update -qq \
    && apt-get install yarn -y \
    && curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - \
    && apt-get install nodejs -y \

    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf \
    /var/lib/apt \
    /var/lib/dpkg \
    /var/lib/cache \
    /var/lib/log

# Create a directory for our application
# and set it as the working directory
RUN mkdir -p /project
WORKDIR /project

# Add our Gemfile
# and install gems

COPY . ./ 
RUN gem install bundler && bundle install --jobs 20 --retry 5 && yarn install

EXPOSE 3000

#ENTRYPOINT ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

