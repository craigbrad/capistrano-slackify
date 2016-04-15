require 'spec_helper'

module Slackify
  describe Payload do
    describe '.build' do
      let(:context) {
        {
          slack_channel: '#general',
          slack_username:'Capistrano',
          slack_emoji: ':ghost:',
          slack_parse: 'default',
          slack_user: 'You',
          slack_fields: ['status', 'stage', 'branch', 'revision', 'hosts'],
          slack_hosts: "192.168.10.1\r192.168.10.2",
          slack_text: ':boom:',
          slack_deploy_finished_color: 'good',
          stage: 'sandbox',
          branch: 'master',
          current_revision: 'SHA',
        }
      }

      let(:payload) {
        %{'payload={"channel":"#general","username":"Capistrano","icon_emoji":":ghost:","parse":"default","attachments":[{"fallback":":boom:","color":"good","text":":boom:","fields":[{"title":"Status","value":"success","short":true},{"title":"Stage","value":"sandbox","short":true},{"title":"Branch","value":"master","short":true},{"title":"Revision","value":"SHA","short":true},{"title":"Hosts","value":"192.168.10.1\\r192.168.10.2","short":true}]}]}'}
      }

      let(:text) { context.fetch(:slack_text) }

      let(:builded_payload) {
        Payload.build(context, :success)
      }

      it 'returns the payload with the specified text' do
        expect(builded_payload).to eq payload
      end

    end
  end
end
