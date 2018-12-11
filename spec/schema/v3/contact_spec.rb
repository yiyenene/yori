require 'spec_helper'

RSpec.describe Yori::Schema::V3::Contact do
  let(:schema) { Yori::Schema::V3::Contact.new }

  describe 'DSL' do
    subject { schema }

    before do
      schema.instance_eval(&block)
    end

    let(:block) do
      proc do
        name 'test_name'
        url 'https://www.example.com'
        email 'test@example.com'
      end
    end

    let(:value) do
      {
        'name' => 'test_name',
        'url' => 'https://www.example.com',
        'email' => 'test@example.com'
      }
    end

    it { is_expected.to eq(value) }
  end
end
