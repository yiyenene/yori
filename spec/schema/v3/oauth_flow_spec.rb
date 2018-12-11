# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::OAuthFlow do
  let(:schema) { Yori::Schema::V3::OAuthFlow.new }

  let(:block) do
    proc do
      authorizationUrl 'https://example.com/api/oauth/dialog'
      scopes do
        scope 'write:pets', 'modify pets in your account'
        scope 'read:pets', 'read your pets'
      end
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }

    context 'missing scopes' do
      before do
        schema.delete('scopes')
      end

      it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
    end
  end
end
