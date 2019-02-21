# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::PathItem do
  let(:schema) { Yori::Schema::V3::PathItem.new }

  let(:block) do
    proc do
      get do
        description 'Returns pets based on ID'
        summary 'Find pets by ID'
        operationId 'getPetsById'
        responses do
          http_status_code '200' do
            description 'pet response'
            content do
              content_type '*/*' do
                schema(
                  type: 'array',
                  items: {
                    '$ref' => '#/components/schemas/Pet'
                  }
                )
              end
            end
          end
        end
      end
      parameters do
        parameter do
          name 'id'
          in_path
          description 'ID of pet to use'
          required true
          schema(
            type: 'array',
            items: {
              type: 'string'
            }
          )
          style 'simple'
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
  end
end
