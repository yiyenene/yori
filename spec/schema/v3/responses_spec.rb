# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::Responses do
  let(:schema) { Yori::Schema::V3::Responses.new }

  let(:block) do
    proc do
      http_status_code '200' do
        description 'a pet to be returned'
        content do
          content_type 'application/json' do
            schema do
              ref '#/components/schemas/Pet'
            end
          end
        end
      end
      default do
        description 'Unexpected error'
        content do
          content_type 'application/json' do
            schema do
              ref '#/components/schemas/ErrorModel'
            end
          end
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

    context 'no response code' do
      before do
        schema.delete('200')
      end

      it { is_expected.to raise_error(Yori::Errors::InvalidSchemaError) }
    end
  end
end
