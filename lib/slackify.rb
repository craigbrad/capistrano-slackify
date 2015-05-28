require 'multi_json'

module Slackify
  class Payload

    def initialize(context)
      @context = context
    end

    def self.build(context, &block)
      new(context).build(&block)
    end

    def build(&block)
      "'payload=#{payload(&block)}'"
    end

    def payload(&block)
      default = {
        channel: fetch(:slack_channel),
        username: fetch(:slack_username),
        icon_emoji: fetch(:slack_emoji),
        parse: fetch(:slack_parse)
      }

      json = yield(default, @context)
      MultiJson.dump(json)
    end

    def fetch(*args, &block)
      @context.fetch(*args, &block)
    end

  end
end
