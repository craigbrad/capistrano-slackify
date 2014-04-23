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

    require 'capistrano/slackfiy'

And then set the required variables in `config/deploy.rb`:

    set :slack_subdomain, 'my_slack_subdomain'
    set :slack_token, 'my_slack_token'

Ensure that you have enabled the [incoming webhooks integration](https://api.slack.com/).

The task will run automatically on deploy, or can be run manually using:

    `bundle exec cap production slack:notify`

By default, this will publish something along the lines of:

    Revision 64a3c1de of my_app deployed to production by seenmyfate

###  Customisation

Any of the defaults can be over-ridden in `config/deploy.rb`:

    set :slack_channel, '#devops'
    set :slack_username, 'Deploybot'
    set :slack_text, -> { "Uh-oh, #{local_user} just deployed" }
    set :slack_emoji, ':trollface:'

### Copyright

Copyright (c) 2014 OnTheBeach Ltd. See LICENSE.txt for
further details.
