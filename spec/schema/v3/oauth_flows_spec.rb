# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::OAuthFlows do
  let(:schema) { Yori::Schema::V3::OAuthFlows.new }

  let(:block) do
    proc do
      authorizationCode do
        authorizationUrl 'https://example.com/api/oauth/dialog'
        tokenUrl 'https://example.com/api/oauth/token'
        scopes do
          scope 'write:pets', 'modify pets in your account'
          scope 'read:pets', 'read your pets'
        end
      end
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }

    context 'authorization code missing tokenUrl' do
      before do
        schema['authorizationCode'].delete('tokenUrl')
      end

      it { is_expected.to raise_error(Yori::Errors::InvalidSchemaError) }
    end
  end
end
