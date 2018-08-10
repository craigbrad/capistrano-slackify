require 'spec_helper'

module Slackify
  describe Payload do
    describe '.build' do
      let(:context) {
        {
          slack_channel: '#general',
          slack_username: 'Capistrano',
          slack_emoji: ':ghost:',
          slack_parse: 'full',
          slack_user: 'You',
          slack_fields: ['status', 'stage', 'branch', 'revision', 'hosts', 'custom_field', 'custom_field_with_proc'],
          slack_custom_field_mapping: {
            'custom_field' => {
              title: 'custom title',
              value: 'custom value',
              short: false
            },
            'custom_field_with_proc' => {
              title: 'custom title proc',
              value: -> {
                'custom value proc'
              },
              short: false
            }
          },
          slack_mrkdwn_in: ['text'],
          slack_hosts: "192.168.10.1\r192.168.10.2",
          slack_text: ':boom:',
          slack_deploy_finished_color: 'good',
          stage: 'sandbox',
          branch: 'master',
          current_revision: 'SHA',
        }
      }

      let(:payload) {
        %{'payload={"channel":"#general","username":"Capistrano","icon_emoji":":ghost:","parse":"full","attachments":[{"fallback":":boom:","color":"good","text":":boom:","fields":[{"title":"Status","value":"success","short":true},{"title":"Stage","value":"sandbox","short":true},{"title":"Branch","value":"master","short":true},{"title":"Revision","value":"SHA","short":true},{"title":"Hosts","value":"192.168.10.1\\r192.168.10.2","short":true},{"title":"custom title","value":"custom value","short":false},{"title":"custom title proc","value":"custom value proc","short":false}],"mrkdwn_in":["text"]}]}'}
      }

      let(:text) { context.fetch(:slack_text) }

      let(:builded_payload) {
        Payload.build(context, :success, slack_channel)
      }

      let(:slack_channel) {
        context.fetch(:slack_channel)
      }

      it 'returns the payload with the specified text' do
        expect(builded_payload).to eq payload
      end

    end
  end
end
