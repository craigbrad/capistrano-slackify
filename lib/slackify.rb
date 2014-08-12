require 'uri'
require 'yajl/json_gem'
module Slackify

  class URL

    def initialize(subdomain, token)
      @subdomain, @token = subdomain, token
    end

    def to_s
      uri.to_s
    end

    private

    def uri
      @uri ||= URI(
        "https://#{@subdomain}.slack.com/services/hooks/incoming-webhook?token=#{@token}"
      )
    end
  end

  module Payload

    module_function

    def slack_payload(message)
      payload = {
        channel: fetch(:slack_channel),
        username: fetch(:slack_username),
        text: message,
        icon_emoji: fetch(:slack_emoji)
      }.to_json
      "payload='#{payload}'"
    end

    def deployer
      ENV['GIT_AUTHOR_NAME'] || `git config user.name`.chomp || local_user
    end

    def time_elapsed
      Time.now.to_i - fetch(:slack_start_time).to_i
    end

    def slack_text_started
      "#{deployer} is deploying #{fetch(:application)} #{fetch(:branch)} to #{fetch(:stage)}..."
    end

    def slack_text_finished
      "Revision #{fetch(:current_revision, fetch(:branch))} of " \
        "#{fetch(:application)} deployed to #{fetch(:stage)} by #{deployer} " \
        "in #{time_elapsed} seconds."
    end

    def slack_url
      URL.new(slack_subdomain, slack_token).to_s
    end

    def slack_subdomain
      fetch(:slack_subdomain) { fail ':slack_subdomain is not set' }
    end

    def slack_token
      fetch(:slack_token) { fail ':slack_token is not set' }
    end

  end
end
self.extend(Slackify::Payload)
