# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::Operation do
  let(:schema) { Yori::Schema::V3::Operation.new }

  let(:block) do
    proc do
      tags ['pet']
      summary 'Updates a pet in the store with form data'
      operationId 'updatePetWithForm'
      parameters do
        parameter do
          name 'petId'
          in_path
          description 'ID of pet that needs to be updated'
          required true
          schema(type: 'string')
        end
      end
      requestBody do
        content do
          content_type 'application/x-www-form-urlencode' do
            schema(
              type: 'object',
              properties: {
                name: {
                  description: 'Updated name of the pet',
                  type: 'string'
                },
                status: {
                  description: 'Updated status of the pet',
                  type: 'string'
                }
              }
            )
          end
        end
      end
      responses do
        http_status_code '200' do
          description 'Pet updated.'
          content do
            content_type 'application/json', {}
            content_type 'application/xml', {}
          end
        end
        http_status_code '405' do
          description 'Invalid input'
          content do
            content_type 'application/json', {}
            content_type 'application/xml', {}
          end
        end
      end
      security do
        schemes do
          scheme 'petstore_auth', %w[write:pets read:pets]
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

    context 'missing responses' do
      before do
        schema.delete('responses')
      end

      it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
    end
  end
end
