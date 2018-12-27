# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::XML do
  let(:schema) { Yori::Schema::V3::XML.new }

  let(:block) do
    proc do
      name 'book'
      namespace 'http://example.com/schema/sample'
      prefix 'sample'
      wrapped false
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }
  end
end
