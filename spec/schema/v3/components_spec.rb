# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::Components do
  let(:schema) { Yori::Schema::V3::Components.new }

  before do
    Yori::Schema::V3::Components.register_component 'response', 'simple_string' do
      description 'A simple string response'
      content do
        content_type 'text/plain' do
          schema do
            ref '#/components/schemas/string'
          end
        end
      end
    end

    Yori::Schema::V3::Components.register_component 'schema', 'string', type: 'string'
  end

  let(:block) do
    proc do
      merge_registered!
    end
  end

  before do
    schema.instance_eval(&block)
    p schema
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }
  end
end
