require 'spec_helper'

RSpec.describe Yori::Schema::V3::ServerVariable do
  let(:schema) { Yori::Schema::V3::ServerVariable.new }

  let(:block) do
    proc do
      enum %w[8443 443]
      default '8443'
      description 'test description'
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'DSL' do
    subject { schema }

    let(:value) do
      {
        'enum' => %w[8443 443],
        'default' => '8443',
        'description' => 'test description'
      }
    end

    it { is_expected.to eq(value) }
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }

    describe 'default' do
      context 'when missing' do
        let(:block) do
          proc do
            enum %w[8443 443]
            description 'test description'
          end
        end

        it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
      end
    end

    describe 'enum' do
      context 'when not array' do
        let(:block) do
          proc do
            enum '8443'
            default '8443'
            description 'test description'
          end
        end

        it { is_expected.to raise_error(Yori::Errors::InvalidSchemaError) }
      end
    end
  end
end
