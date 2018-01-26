source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
gem 'rails'
gem 'pg', '~> 0.18'
gem 'rails_12factor', group: :production
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'sdoc',          group: :doc
gem 'puma'
gem 'binding_of_caller'
gem 'dotenv-rails'
gem 'rest-client'

group :development, :test do
  gem 'pry-byebug'
  gem 'spring'
  gem 'tzinfo-data', platforms: [:mingw, :mswin]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  gem 'better_errors'
  gem 'listen'
end

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'database_cleaner'
end