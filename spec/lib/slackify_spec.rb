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
        %{'payload={"channel":"#general","username":"Capistrano","text":":boom:","icon_emoji":":ghost:","parse":"default"}'}
      }

      let(:text) { context.fetch(:slack_text) }

      it 'returns the payload with the specified text' do
        expect(Payload.build(context, text)).to eq payload
      end

    end
  end
end
