require 'spec_helper'

RSpec.describe Yori::Schema::V3::ExternalDocumentation do
  let(:schema) { Yori::Schema::V3::ExternalDocumentation.new }

  let(:block) do
    proc do
      description 'Find more info here'
      url 'https://example.com'
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'DSL' do
    subject { schema }

    let(:value) do
      {
        'description' => 'Find more info here',
        'url' => 'https://example.com'
      }
    end

    it { is_expected.to eq(value) }
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }

    describe 'url' do
      context 'when missing' do
        before do
          schema.delete('url')
        end

        it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
      end
    end
  end
end
