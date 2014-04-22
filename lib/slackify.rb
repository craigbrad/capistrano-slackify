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

    def slack_payload
      {
        channel: fetch(:slack_channel),
        username: fetch(:slack_username),
        text: fetch(:slack_text),
        icon_emoji: fetch(:slack_emoji)
      }.to_json
    end

    def slack_text
      "Revision #{fetch(:current_revision, fetch(:branch))} of " \
        "#{fetch(:application)} deployed to #{fetch(:stage)} by #{local_user}"
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
