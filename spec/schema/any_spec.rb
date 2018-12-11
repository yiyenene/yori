# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::Any do
  let(:schema) { Yori::Schema::Any.new }

  let(:block) do
    proc do
      sample 'aaa'
      sample2 do
        child1 'bbb'
      end
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'anonymous dsl' do
    subject { schema }

    let(:expected) do
      {
        'sample' => 'aaa',
        'sample2' => {
          'child1' => 'bbb'
        }
      }
    end

    it { is_expected.to eq(expected) }
  end
end
