# How to run the project

## With dump

* create .env file with missing vars (DB, etc)
* bundle install
* rails db:create
* Import your dump to the created DB
* rails s


## Without dump

* create .env file with missing vars (DB, etc)
* bundle install
* rails db:setup
* rails s


# Dev improvements to be worked in a spare time

- all models in english
- rename all DB tables
- set default email config on ApplicationMailer file
