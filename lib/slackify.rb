require 'yajl/json_gem'

module Slackify
  class Payload

    attr_reader :status
    protected :status

    def initialize(context, status)
      @context, @status = context, status
    end

    def self.build(context, status)
      new(context, status).build
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

    def fetch(*args, &block)
      @context.fetch(*args, &block)
    end

  end
end
