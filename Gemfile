source 'https://rubygems.org'
ruby '~> 2.3.0'

gem 'figaro'
gem 'mixpanel-ruby'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

## For the admin interface
## We use activeadmin at master because the latest released version doesn't
## yet support Rails 4.x: http://stackoverflow.com/questions/26044264/activeadmin-bundle-error
gem 'activeadmin', github: 'activeadmin'
gem 'devise', '~> 3.5.2'
gem 'cancan' # or cancancan
gem 'draper'
gem 'pundit'

# to make Windows happy
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]

## For Mailgun
gem 'mailgun_rails'

## For Mailtrap
gem 'rest-client'
gem 'json'

## for scheduling
gem 'rufus-scheduler'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'rails_12factor', group: :production

gem 'premailer-rails'
gem 'nokogiri'
gem 'pry'
	
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Shows better errors, apparently
  gem 'better_errors'

end
