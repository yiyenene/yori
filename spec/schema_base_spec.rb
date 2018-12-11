require 'spec_helper'

class TestingSchema < Yori::SchemaBase
  fields :name, :title
end

class TestingSchemaParent < Yori::SchemaBase
  field_block :single, TestingSchema
  hash_field_block :hash, :hash_key, TestingSchema
  array_field_block :array, :item, TestingSchema
end

RSpec.describe Yori::SchemaBase do
  subject { test_target }
  let(:test_target) { TestingSchema.new }

  describe '.fields' do
    before do
      test_target.name('aaa')
    end

    it { is_expected.to eq('name' => 'aaa') }
  end

  context 'Parent' do
    subject { parent }
    let(:parent) { TestingSchemaParent.new }

    describe '.field_block simple' do
      before do
        parent.single do
          title 'test_title'
        end
      end

      it { is_expected.to eq('single' => { 'title' => 'test_title' }) }
    end

    describe '.field_block direct assignment' do
      before do
        parent.single('title' => 'test_title')
      end

      it { is_expected.to eq('single' => { 'title' => 'test_title' }) }
    end

    describe '.hash_field_block' do
      before do
        parent.hash do
          hash_key '/pets' do
            title 'pets_title'
          end
        end
      end

      it { is_expected.to eq('hash' => { '/pets' => { 'title' => 'pets_title' } }) }
    end

    describe '.array_filed_block array' do
      before do
        parent.array do
          item do
            title 'test1'
          end
          item do
            title 'test2'
          end
        end
      end

      it { is_expected.to eq('array' => [{ 'title' => 'test1' }, { 'title' => 'test2'}]) }
    end
  end
end
