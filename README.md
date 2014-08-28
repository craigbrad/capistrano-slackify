# Capistrano Slackify [![Build Status](https://travis-ci.org/onthebeach/capistrano-slackify.svg)](https://travis-ci.org/onthebeach/capistrano-slackify)

Publish deploy notifications to [Slack](https://slack.com) - for [Capistrano v3](https://github.com/capistrano/capistrano).

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-slackify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-slackify

## Usage

Require the gem in your `Capfile`:

    require 'capistrano/slackify'

And then set the required variables in `config/deploy.rb`:

    set :slack_subdomain, 'my_slack_subdomain'
    set :slack_token, 'my_slack_token'

Ensure that you have enabled the [incoming webhooks integration](https://api.slack.com/).

The task will run automatically on deploy, or can be run manually using:

    `bundle exec cap production slack:notify`

By default, this will publish something along the lines of:

    Revision 64a3c1de of my_app deployed to production by seenmyfate in 333 seconds.

###  Customisation

Any of the defaults can be over-ridden in `config/deploy.rb`:

    set :slack_channel, '#devops'
    set :slack_username, 'Deploybot'
    set :slack_emoji, ':trollface:'
    set :slack_user, ENV['GIT_AUTHOR_NAME']
    set :slack_text, -> {
      "Revision #{fetch(:current_revision, fetch(:branch))} of " \
      "#{fetch(:application)} deployed to #{fetch(:stage)} by #{local_user} " \
      "in #{elapsed} seconds."
    }
    set :slack_deploy_starting_text, -> {  
      "Notifying Slack of #{fetch(:stage)} deploy starting with revision/branch #{fetch(:current_revision, fetch(:branch))} for #{fetch(:application)}"
    }

### Copyright

Copyright (c) 2014 OnTheBeach Ltd. See LICENSE.txt for
further details.
