require 'spec_helper'

module Slackify
  describe URL do
    let(:url) { URL.new(subdomain, token) }
    let(:subdomain) { 'me' }
    let(:token) { 'abc123' }

    describe '.new' do
      it 'takes a subdomain and a token' do
        expect(url)
      end
    end

    describe '#to_s' do
      it 'returns the url as a string' do
        expect(url.to_s).
          to eq 'https://me.slack.com/services/hooks/incoming-webhook?token=abc123'
      end
    end
  end
end
