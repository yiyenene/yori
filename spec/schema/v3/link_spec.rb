# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yori::Schema::V3::Link do
  let(:schema) { Yori::Schema::V3::Link.new }

  let(:block) do
    proc do
      operationId 'getUserAddress'
      parameters do
        parameter 'userId', '$request.path.id'
      end
    end
  end

  before do
    schema.instance_eval(&block)
  end

  describe 'validate!' do
    subject { -> { schema.validate! } }

    it { is_expected.not_to raise_error }

    context 'opetaionId and operationRef both exists' do
      before do
        schema.operationRef('test')
      end

      it { is_expected.to raise_error(Yori::Errors::InvalidSchemaError) }
    end
  end
end
