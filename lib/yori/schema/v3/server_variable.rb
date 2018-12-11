# frozen_string_literal: true

module Yori
  module Schema
    module V3
      # ServerVariable: An object representing a Server Variable for server URL template substitution.
      # @enum: An enumeration of string values to be used if the substitution options are from a limited set.
      # @default: REQUIRED. The default value to use for substitution, and to send, if an alternate value is not supplied.
      #   Unlike the Schema Object's default, this value MUST be provided by the consumer.
      # @description: An optional description for the server variable. CommonMark syntax MAY be used for rich text representation.
      class ServerVariable < Yori::SchemaBase
        fields :enum, :default, :description

        def validate!
          validate_require_fields!('default')
          validate_enum! if key?('enum')
        end

        def validate_enum!
          validate_field_value_type!('enum', Array)
        end
      end
    end
  end
end
