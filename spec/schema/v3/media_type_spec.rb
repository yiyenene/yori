require 'spec_helper'

RSpec.describe Yori::Schema::V3::MediaType do
  let(:schema) { Yori::Schema::V3::MediaType.new }

  let(:block) do
    proc do
      schema do
        ref '#/components/schemas/Pet'
      end
      examples do
        example 'cat' do
          summary 'An example of a cat'
          value(
            name: 'Flutty',
            petType: 'Cat',
            color: 'White',
            gender: 'male',
            breed: 'Persian'
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
  end
end
