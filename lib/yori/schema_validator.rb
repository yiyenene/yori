# frozen_string_literal: true

module Yori
  # SchemaValidator: Common validate methods of Schema.
  class SchemaValidator
    def initialize(schema)
      @schema = schema
    end

    attr_reader :schema

    def validate_require_fields!(*fields)
      fields.each do |field|
        next if schema.key?(field)
        raise Yori::Errors::MissingRequiredFieldError, "#{field} of #{simple_class_name} is Required."
      end
    end

    def validate_field_value_type!(field, klass)
      value = schema[field]
      return if value.nil? || value.is_a?(klass)
      raise Yori::Errors::InvalidSchemaError, "value of #{field} is not #{klass}."
    end

    def validate_limit_field_values!(field, *values)
      value = schema[field]
      return if values.include?(value)
      raise Yori::Errors::InvalidSchemaError, "Valid values of #{field} are #{values.join(', ')}."
    end

    def validate_mutually_exclusive_fields!(field1, field2)
      return if schema.key?(field1) ^ schema.key?(field2)
      raise Yori::Errors::InvalidSchemaError, "#{field1} and #{field2} are mutually exclusive."
    end

    def simple_class_name
      schema.class.name.split('::').last
    end
  end
end
