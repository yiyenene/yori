# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::OpenAPI do
  let(:schema) { Yori::Schema::V3::OpenAPI.new }

  let(:block) do
    proc do
      openapi '3.0.0'
      info do
        title 'Sample Pet Store App'
        version '1.0.1'
      end
      paths do
        path '/pets' do
          get do
            description 'Retruns pets based on ID'
            responses do
              status '200' do
                description 'pet response'
              end
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

    context 'missing openapi' do
      before do
        schema.delete('openapi')
      end

      it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
    end
  end
end
