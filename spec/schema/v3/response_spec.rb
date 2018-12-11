# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::Response do
  let(:schema) { Yori::Schema::V3::Response.new }

  let(:block) do
    proc do
      description 'A simple string response'
      content do
        content_type 'text/plain' do
          schema(
            type: 'string'
          )
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

    context 'missing description' do
      before do
        schema.delete('description')
      end

      it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
    end
  end
end
