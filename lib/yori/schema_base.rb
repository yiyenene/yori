# frozen_string_literal: true

require 'forwardable'

module Yori
  # Yori::SchemaBase
  class SchemaBase < Hash
    extend Forwardable

    def_delegators :validator,
                   :validate_require_fields!,
                   :validate_field_value_type!,
                   :validate_limit_field_values!,
                   :validate_mutually_exclusive_fields!

    def validator
      @validator ||= Yori::SchemaValidator.new(self)
    end

    def validate!; end

    def ref(value)
      self['$ref'] = value
    end

    class << self
      def eval_input!(klass, value = nil, &block)
        return eval_class!(klass, &block) unless value

        case value
        when String
          value # pass as a runtime expression
        when Hash
          eval_hash!(klass, value)
        else
          raise 'direct assignment value must be a Hash'
        end
      end

      def eval_hash!(klass, value)
        klass[value].tap do |c|
          raise 'must inherit SchemaBase class' unless c.is_a?(SchemaBase)
          c.validate!
        end
      end

      def eval_class!(klass, &block)
        klass.new.tap do |c|
          raise 'must inherit SchemaBase class' unless c.is_a?(SchemaBase)
          c.instance_eval(&block)
          c.validate!
        end
      end

      private

      def fields(*names)
        names.each do |name|
          define_method(name) { |value| self[name.to_s] = value }
        end
      end

      def field_block(name, schema_class)
        define_method(name) do |value = nil, &block|
          c = self.class.eval_input!(schema_class, value, &block)
          self[name.to_s] = c
        end
      end

      def array_field_block(name, item_name, schema_class)
        define_method(item_name) do |value = nil, &block|
          c = self.class.eval_input!(schema_class, value, &block)
          self[name.to_s] ||= []
          self[name.to_s] << c
        end
        define_method(name) do |&block|
          self[name.to_s] = []
          instance_eval(&block)
        end
      end

      def hash_field_block(name, key_name, schema_class)
        define_method(key_name) do |key, value = nil, &block|
          c = self.class.eval_input!(schema_class, value, &block)
          self[name.to_s] ||= {}
          self[name.to_s][key.to_s] = c
        end
        define_method(name) do |&block|
          self[name.to_s] = {}
          instance_eval(&block)
        end
      end
    end
  end
end
