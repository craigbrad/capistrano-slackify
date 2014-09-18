require 'uri'
require 'yajl/json_gem'
require 'singleton'

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

  class Payload

    attr_reader :status
    protected :status

    def self.build(status)
      new(status).build
    end

    def initialize(status)
      @status = status
    end

    def build
      "'payload=#{payload}'"
    end

    def payload
      {
        channel: fetch(:slack_channel),
        username: fetch(:slack_username),
        text: slack_text,
        icon_emoji: fetch(:slack_emoji),
        parse: fetch(:slack_parse)
      }.to_json
    end

    def slack_text
      if @status == :start
        fetch(:slack_deploy_starting_text)
      else
        fetch(:slack_text)
      end
    end

  end

  class Configuration
    include Singleton

    def url
      URL.new(subdomain, token).to_s
    end

    private

    def subdomain
      fetch(:slack_subdomain) { fail ':slack_subdomain is not set' }
    end

    def token
      fetch(:slack_token) { fail ':slack_token is not set' }
    end
  end
end
