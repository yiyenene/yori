require 'spec_helper'

RSpec.describe Yori::Schema::V3::Server do
  let(:schema) { Yori::Schema::V3::Server.new }

  let(:block) do
    proc do
      url 'https://www.example.com/api/{version}/sample'
      description 'test description'
      variables do
        variable 'version' do
          default 'v1'
        end
      end
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'DSL' do
    subject { schema }

    let(:value) do
      {
        'url' => 'https://www.example.com/api/{version}/sample',
        'description' => 'test description',
        'variables' => {
          'version' => {
            'default' => 'v1'
          }
        }
      }
    end

    it { is_expected.to eq(value) }
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }

    describe 'url' do
      context 'when missing' do
        let(:block) do
          proc do
            description 'test description'
          end
        end

        it { is_expected.to raise_error(Yori::Errors::MissingRequiredFieldError) }
      end
    end
  end
end
