# frozen_string_literal: true

module Yori
  module Schema
    module V3
      # Discriminator
      #   When request bodies or response payloads may be one of a number of different schemas,
      #   a discriminator object can be used to aid in serialization, deserialization, and validation.
      #   The discriminator is a specific object in a schema which is used to inform the consumer of the specification of an alternative schema based on the value associated with it.
      #   When using the discriminator, inline schemas will not be considered.
      class Discriminator < Yori::SchemaBase
        # @!method propertyName
        #   REQUIRED. The name of the property in the payload that will hold the discriminator value.
        fields :propertyName
        # @!method mapping
        #   An object to hold mappings between payload values and schema names or references.
        hash_field :mapping, :map

        def validate!
          validate_require_fields!('propertyName')
        end
      end
    end
  end
end
