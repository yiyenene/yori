require 'spec_helper'

RSpec.describe Yori::Schema::V3::Info do
  let(:schema) { Yori::Schema::V3::Info.new }

  let(:block) do
    proc do
      title 'Sample Pet Store App'
      description 'This is a sample server for a pet store.'
      termsOfService 'http://example.com/terms/'
      contact do
        name 'API Support'
        url 'http://www.example.com/support'
        email 'support@example.com'
      end
      license do
        name 'Apache 2.0'
        url 'http://www.apache.org/licenses/LICENSE-2.0.html'
      end
      version '1.0.1'
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'DSL' do
    subject { schema }

    let(:value) do
      {
        'title' => 'Sample Pet Store App',
        'description' => 'This is a sample server for a pet store.',
        'termsOfService' => 'http://example.com/terms/',
        'contact' => {
          'name' => 'API Support',
          'url' => 'http://www.example.com/support',
          'email' => 'support@example.com'
        },
        'license' => {
          'name' => 'Apache 2.0',
          'url' => 'http://www.apache.org/licenses/LICENSE-2.0.html'
        },
        'version' => '1.0.1'
      }
    end

    it { is_expected.to eq(value) }
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }

    describe 'title' do
      context 'when missing' do
        before do
          schema.delete('title')
        end

        it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
      end
    end

    describe 'version' do
      context 'when missing' do
        before do
          schema.delete('version')
        end

        it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
      end
    end
  end
end
