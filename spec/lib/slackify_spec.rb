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
          slack_deploy_starting_text: 'duck!'
        }
      }

      context 'when starting' do
        let(:payload) {
          %{'payload={"channel":"#general","username":"Capistrano","text":"duck!","icon_emoji":":ghost:","parse":"default"}'}
        }

        it 'returns the starting payload' do
          expect(Payload.build(context, :start)).to eq payload
        end
      end

      context 'when finishing' do
        let(:payload) {
          %{'payload={"channel":"#general","username":"Capistrano","text":":boom:","icon_emoji":":ghost:","parse":"default"}'}
        }

        it 'returns the finishing payload' do
          expect(Payload.build(context, :finish)).to eq payload
        end
      end

    end
  end
end
