# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::SecurityScheme do
  let(:schema) { Yori::Schema::V3::SecurityScheme.new }

  before do
    schema.instance_eval(&block)
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    context 'http' do
      let(:block) do
        proc do
          type 'http'
          scheme 'basic'
        end
      end

      it { is_expected.not_to raise_error }

      context 'when scheme missing' do
        before do
          schema.delete('scheme')
        end

        it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
      end
    end

    context 'apiKey' do
      let(:block) do
        proc do
          type 'apiKey'
          name 'api_key'
          in_header
        end
      end

      it { is_expected.not_to raise_error }

      context 'when name missing' do
        before do
          schema.delete('name')
        end

        it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
      end

      context 'when in missing' do
        before do
          schema.delete('in')
        end

        it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
      end
    end

    context 'oauth2' do
      let(:block) do
        proc do
          type 'oauth2'
          flows do
            implicit do
              authorizationUrl 'https://example.com/api/oauth/dialog'
              scopes do
                scope 'write:pets', 'modify pets in your account'
                scope 'read:pets', 'read your pets'
              end
            end
          end
        end
      end

      it { is_expected.not_to raise_error }
    end
  end
end
