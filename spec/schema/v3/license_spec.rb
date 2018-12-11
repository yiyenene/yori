require 'spec_helper'

RSpec.describe Yori::Schema::V3::License do
  let(:schema) { Yori::Schema::V3::License.new }

  describe 'DSL' do
    subject { schema }

    before do
      schema.instance_eval(&block)
    end

    let(:block) do
      proc do
        name 'test_name'
        url 'https://www.example.com'
      end
    end

    let(:value) do
      {
        'name' => 'test_name',
        'url' => 'https://www.example.com'
      }
    end

    it { is_expected.to eq(value) }
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    context 'name exists' do
      before do
        schema['name'] = 'test'
      end

      it { is_expected.not_to raise_error }
    end

    context 'name missing' do
      it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
    end
  end
end
