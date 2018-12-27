# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::Discriminator do
  let(:schema) { Yori::Schema::V3::Discriminator.new }

  let(:block) do
    proc do
      propertyName 'pet_type'
      mapping do
        map 'dog', '#/component/schemas/Dog'
      end
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }

    context 'missing propertyName' do
      before do
        schema.delete('propertyName')
      end

      it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
    end
  end
end
