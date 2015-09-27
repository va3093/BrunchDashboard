# Getting started:

1. Install Ruby on Rails.
1. Install PostgreSQL.
1. Create a user in your PostgreSQL db with the name 'kxbrunch', password 'kxbrunch', and permission to create databases.

Then in the root of your repository run:

1. `bundler`
1. `rake db:setup`
1. `rails server`

Then go to [http://localhost:3000/signup/](http://localhost:3000/signup/) to see the site!

## Registering and signing in

We use email tokens to sign in. In the development environments, we use [MailCatcher](http://mailcatcher.me/) as a mock SMTP server. To use it:

1. Install it by going to a terminal and entering `gem install mailcatcher`.
2. Run it by entering `mailcatcher` in a terminal window.
3. View sent mail at [http://localhost:1080/](http://localhost:1080/).
