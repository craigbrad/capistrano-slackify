require 'multi_json'

module Slackify
  class Payload

    def initialize(context, status)
      @context = context
      @status = status
    end

    def self.build(context, status, channel)
      new(context, status).build(channel)
    end

    def build(channel)
      "'payload=#{payload(channel)}'"
    end

    def payload(channel)
      fields = fetch(:slack_fields).each_with_object([]) { |field, fields|
        if fields_map[field].fetch(:value).respond_to?(:call)
          field_data = fields_map[field]
          field_data[:value] = field_data.fetch(:value).call
          fields.push(field_data)
        else
          fields.push(fields_map[field])
        end
      }

      MultiJson.dump(
        {
          channel: channel,
          username: fetch(:slack_username),
          icon_emoji: fetch(:slack_emoji),
          parse: fetch(:slack_parse),
          attachments: [
            {
              fallback: text,
              color: color,
              text: text,
              fields: fields,
              mrkdwn_in: fetch(:slack_mrkdwn_in),
            }
          ]
        }
      )
    end

    def fields_map
      @fields_map ||= [
        default_field_map,
        fetch(:slack_custom_field_mapping),
      ].reduce(&:merge)
    end

    def default_field_map
      {
        'status' => {
          title: 'Status',
          value: @status,
          short: true
        },
        'stage' => {
          title: 'Stage',
          value: fetch(:stage),
          short: true
        },
        'branch' => {
          title: 'Branch',
          value: fetch(:branch),
          short: true
        },
        'revision' => {
          title: 'Revision',
          value: fetch(:current_revision),
          short: true
        },
        'hosts' => {
          title: 'Hosts',
          value: fetch(:slack_hosts),
          short: true
        }
      }
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
