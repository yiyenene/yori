require 'spec_helper'

RSpec.describe Yori::Schema::V3::Example do
  let(:schema) { Yori::Schema::V3::Example.new }

  let(:block) do
    proc do
      summary 'example'
      description 'description'
      value('foo' => 'bar')
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'DSL' do
    subject { schema }

    let(:value) do
      {
        'summary' => 'example',
        'description' => 'description',
        'value' => { 'foo' => 'bar' }
      }
    end

    it { is_expected.to eq(value) }
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }

    context 'value and externalValue is exists' do
      before do
        schema.externalValue('http://external.com/foo.json')
      end

      it { is_expected.to raise_error(Yori::Errors::InvalidSchemaError) }
    end

    context 'value and externalValue is missing' do
      before do
        schema.delete('value')
      end

      it { is_expected.to raise_error(Yori::Errors::InvalidSchemaError) }
    end
  end
end
