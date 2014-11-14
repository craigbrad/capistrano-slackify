# Capistrano Slackify [![Build Status](https://travis-ci.org/onthebeach/capistrano-slackify.svg)](https://travis-ci.org/onthebeach/capistrano-slackify) [![Code Climate](https://codeclimate.com/github/onthebeach/capistrano-slackify/badges/gpa.svg)](https://codeclimate.com/github/onthebeach/capistrano-slackify)

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

    set :slack_url, 'https://hooks.slack.com/services/your/webhook/url'

Ensure that you have enabled the [incoming webhooks integration](https://api.slack.com/) -
copy/paste the webhook url provided in the setup instructions.

The task will run automatically on deploy. Alternatively, you can notify of a deploy starting manually by using:

    bundle exec cap production slack:notify_started

Or to notify of a finished deploy:

    bundle exec cap production slack:notify_started

By default, this will publish something along the lines of:

    Revision 64a3c1de of my_app deployed to production by seenmyfate in 333 seconds.

###  Customisation

Any of the defaults can be over-ridden in `config/deploy.rb`:

    set :slack_channel, '#devops'
    set :slack_username, 'Deploybot'
    set :slack_emoji, ':trollface:'
    set :slack_user, ENV['GIT_AUTHOR_NAME']
    set :slack_text, -> {
      elapsed = Integer(fetch(:time_finished) - fetch(:time_started))
      "Revision #{fetch(:current_revision, fetch(:branch))} of " \
      "#{fetch(:application)} deployed to #{fetch(:stage)} by #{fetch(:slack_user)} " \
      "in #{elapsed} seconds."
    }
    set :slack_deploy_starting_text, -> {
      "#{fetch(:stage)} deploy starting with revision/branch #{fetch(:current_revision, fetch(:branch))} for #{fetch(:application)}"
    }

To configure the way slack parses your message (see 'Parsing Modes' at https://api.slack.com/docs/formatting) use the `:slack_parse` setting:

  set :slack_parse, 'none' # available options: 'default', 'none', 'full'

### Copyright

Copyright (c) 2014 OnTheBeach Ltd. See LICENSE.txt for
further details.
