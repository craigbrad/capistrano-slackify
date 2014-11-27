require 'yajl/json_gem'

module Slackify
  class Payload

    attr_reader :text
    protected :text

    def initialize(context, text)
      @context, @text = context, text
    end

    def self.build(context, text)
      new(context, text).build
    end

    def build
      "'payload=#{payload}'"
    end

    def payload
      {
        channel: fetch(:slack_channel),
        username: fetch(:slack_username),
        text: text,
        icon_emoji: fetch(:slack_emoji),
        parse: fetch(:slack_parse)
      }.to_json
    end

    def fetch(*args, &block)
      @context.fetch(*args, &block)
    end

  end
end
