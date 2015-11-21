require 'multi_json'

module Slackify
  class Payload

    def initialize(context, status)
      @context = context
      @status = status
    end

    def self.build(context, status)
      new(context, status).build
    end

    def build
      "'payload=#{payload}'"
    end

    def payload
      MultiJson.dump(
        {
          channel: fetch(:slack_channel),
          username: fetch(:slack_username),
          icon_url: fetch(:slack_icon_url),
          icon_emoji: fetch(:slack_emoji),
          parse: fetch(:slack_parse),
          attachments: [
            {
              fallback: text,
              color: color,
              text: text,
              fields: [
                {
                  title: 'Status',
                  value: @status,
                  short: true
                },
                {
                  title: 'Stage',
                  value: fetch(:stage),
                  short: true
                },
                {
                  title: 'Branch',
                  value: fetch(:branch),
                  short: true
                },
                {
                  title: 'Revision',
                  value: fetch(:current_revision),
                  short: true
                },
                {
                  title: 'Hosts',
                  value: fetch(:slack_hosts),
                  short: true
                },
              ]
            }
          ]
        }
      )
    end

    def fetch(*args, &block)
      @context.fetch(*args, &block)
    end

    def text
      @text ||= case @status
      when :starting
        fetch(:slack_deploy_starting_text)
      when :success
        fetch(:slack_text)
      when :failed
        fetch(:slack_deploy_failed_text)
      end
    end

    def color
      case @status
      when :starting
        fetch(:slack_deploy_starting_color)
      when :success
        fetch(:slack_deploy_finished_color)
      when :failed
        fetch(:slack_deploy_failed_color)
      end
    end
  end
end
