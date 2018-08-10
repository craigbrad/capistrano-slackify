# Capistrano Slackify [![Build Status](https://travis-ci.org/onthebeach/capistrano-slackify.svg)](https://travis-ci.org/onthebeach/capistrano-slackify) [![Code Climate](https://codeclimate.com/github/onthebeach/capistrano-slackify/badges/gpa.svg)](https://codeclimate.com/github/onthebeach/capistrano-slackify) [![Gem Version](https://badge.fury.io/rb/capistrano-slackify.svg)](http://badge.fury.io/rb/capistrano-slackify)

Publish deploy notifications to [Slack](https://slack.com) - for [Capistrano v3](https://github.com/capistrano/capistrano).

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-slackify', require: false

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

    bundle exec cap production slack:notify_finished

By default, this will publish something along the lines of:

    Revision 64a3c1de of my_app deployed to production by seenmyfate in 333 seconds.

If a deploy has failed, the following message will be published by default:

    production deploy of my_app with revision/branch 64a3c1de failed

As with the other tasks, it is also possible to notify failures manually:

    bundle exec cap production slack:notify_failed

###  Customisation

Any of the defaults can be over-ridden in `config/deploy.rb`:

    set :slack_channel, ['#devops', '#other-channel']
    set :slack_username, 'Deploybot'
    set :slack_emoji, ':trollface:'
    set :slack_user, ENV['GIT_AUTHOR_NAME']
    set :slack_fields, ['status', 'stage', 'branch', 'revision', 'hosts']
    set :slack_mrkdwn_in, ['pretext', 'text', 'fields']
    set :slack_hosts, -> { release_roles(:all).map(&:hostname).join("\n") }
    set :slack_text, -> {
      elapsed = Integer(fetch(:time_finished) - fetch(:time_started))
      "Revision #{fetch(:current_revision, fetch(:branch))} of " \
      "#{fetch(:application)} deployed to #{fetch(:stage)} by #{fetch(:slack_user)} " \
      "in #{elapsed} seconds."
    }
    set :slack_deploy_starting_text, -> {
      "#{fetch(:stage)} deploy starting with revision/branch #{fetch(:current_revision, fetch(:branch))} for #{fetch(:application)}"
    }
    set :slack_deploy_failed_text, -> {
      "#{fetch(:stage)} deploy of #{fetch(:application)} with revision/branch #{fetch(:current_revision, fetch(:branch))} failed"
    }
    set :slack_deploy_finished_color, 'good'
    set :slack_deploy_failed_color, 'danger'
    set :slack_notify_events, [:started, :finished, :failed]

You can setup custom fields by defining a mapping for how to display them in slack:

    set :slack_fields, ['status', 'environment', 'docker_image']
    # You could also add your custom mappings to the defaults with:
    # set :slack_fields, fetch(:slack_fields).push('environment', 'docker_image')
    set :slack_custom_field_mapping, -> {
      {
        'environment' => {
          title: 'Environment',
          value: -> {
            if fetch(:stage) == :production
              'production'
            else
              "staging-#{fetch(:staging_name)}"
            end
          },
          short: true,
        },
        'docker_image' => {
          title: 'Docker image',
          value: fetch(:docker_image),
          short: false,
        },
      }
    }

To configure the way slack parses your message (see 'Parsing Modes' at https://api.slack.com/docs/formatting) use the `:slack_parse` setting:

    set :slack_parse, 'none' # available options: 'none', 'full'

### Copyright

Copyright (c) 2014 OnTheBeach Ltd. See LICENSE.txt for
further details.
