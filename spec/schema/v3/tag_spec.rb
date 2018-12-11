# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::Tag do
  let(:schema) { Yori::Schema::V3::Tag.new }

  let(:block) do
    proc do
      name 'pet'
      description 'Pets operations'
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }

    context 'missing name' do
      before do
        schema.delete('name')
      end

      it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
    end
  end
end
