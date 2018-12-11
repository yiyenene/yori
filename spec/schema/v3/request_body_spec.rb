require 'spec_helper'

RSpec.describe Yori::Schema::V3::RequestBody do
  let(:schema) { Yori::Schema::V3::RequestBody.new }

  let(:block) do
    proc do
      description 'user to add to the system'
      content do
        content_type 'application/json' do
          schema do
            ref '#/components/schemas/User'
          end
          examples do
            example 'user' do
              summary 'User Example'
              externalValue 'http://foo.bar/examples/user-example.json'
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

    context 'content is missing' do
      before do
        schema.delete('content')
      end

      it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
    end
  end
end
