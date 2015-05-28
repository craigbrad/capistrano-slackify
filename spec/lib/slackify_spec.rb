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
          slack_text: ':boom:',
        }
      }

      let(:payload) {
        %{'payload={"channel":"#general","username":"Capistrano","icon_emoji":":ghost:","parse":"default","text":":boom:"}'}
      }

      let(:text) { context.fetch(:slack_text) }

      let(:builded_payload) {
        Payload.build context do |default, context|
          default[:text] = text
          default
        end
      }

      it 'returns the payload with the specified text' do
        expect(builded_payload).to eq payload
      end

    end
  end
end
