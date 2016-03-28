# About

The Brunch dashboard is a simple volunteer dashboard built for the "Kings Cross Brunch" that is a simple a group of about 70 people serving the homeless and vulnerable people in Kings Cross by hosting a Sunday brunch to members of the community. With coffee, bacon rolls and conversation this group of people are able to bridge the gaps between people in the community that society has created. 

The brunch dashboard is a tool to take some of the admin load off of the leaders of the brunch so that they can focus on doing what they do best, which is serving the community.

![alt text](https://github.com/va3093/BrunchDashboard/blob/master/Readme_assets/screenshot1.png "Brunch dashboard")


# Current features
- Sign up for people wanting to volunteer
- Easy dashboard for volunteers to add and remove themselves from events
- Automated monthly emails with links to sign up to events
- Automated weekly reminder emails
- Automated emails to get more volunteers for weeks with few volunteers

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
