require 'spec_helper'

RSpec.describe Yori::Schema::V3::Encoding do
  let(:schema) { Yori::Schema::V3::Encoding.new }

  let(:block) do
    proc do
      contentType 'image/png, image/jpeg'
      headers do
        header 'X-Rate-Limit-Limit' do
          description 'The number of allowed requests in the current period'
          schema(type: 'integer')
        end
      end
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
