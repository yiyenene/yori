# frozen_string_literal: true

module Yori
  module Schema
    module V3
      # Example:
      # @summary: Short description for the example.
      # @description: Long description for the example. CommonMark syntax MAY be used for rich text representation.
      # @value: Embedded literal example. The value field and externalValue field are mutually exclusive. To represent examples of media types that cannot naturally represented in JSON or YAML, use a string value to contain the example, escaping where necessary.
      # @externalValue: A URL that points to the literal example. This provides the capability to reference examples that cannot easily be included in JSON or YAML documents. The value field and externalValue field are mutually exclusive.
      class Example < Yori::SchemaBase
        fields :summary, :description, :value, :externalValue

        def validate!
          validate_mutually_exclusive_fields!('value', 'externalValue')
        end
      end
    end
  end
end
