require 'spec_helper'

RSpec.describe Yori::Schema::V3::Parameter do
  let(:schema) { Yori::Schema::V3::Parameter.new }

  let(:block) do
    proc do
      name 'token'
      in_header
      description 'token to be passed as a header'
      required true
      schema(
        type: 'array',
        items: {
          type: 'integer',
          format: 'int64'
        }
      )
      style 'simple'
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }

    context 'name is missing' do
      before do
        schema.delete('name')
      end

      it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
    end

    context 'in is missing' do
      before do
        schema.delete('in')
      end

      it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
    end

    context 'path type' do
      let(:block) do
        proc do
          name 'username'
          in_path
          description 'username to fetch'
          required true
          schema(
            type: 'string'
          )
        end
      end

      context 'required is missing' do
        before do
          schema.delete('required')
        end

        it { is_expected.to raise_error(Yori::Errors::InvalidSchemaError) }
      end
    end

    context 'use content' do
      let(:block) do
        proc do
          in_query
          name 'coodinates'
          content do
            content_type 'application/json' do
              schema(
                type: 'object',
                required: %w[lat long],
                properties: {
                  'lat' => {
                    type: 'number'
                  },
                  'long' => {
                    type: 'number'
                  }
                }
              )
            end
          end
        end
      end

      context 'when schema and content both exists' do
        before do
          schema.schema(type: 'string')
        end

        it { is_expected.to raise_error(Yori::Errors::InvalidSchemaError) }
      end
    end
  end
end
