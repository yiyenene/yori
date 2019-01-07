# frozen_string_literal: true

require 'yori/schema/v3/discriminator'
require 'yori/schema/v3/xml'
require 'yori/schema/v3/external_documentation'

module Yori
  module Schema
    module V3
      # Schema: The Schema Object allows the definition of input and output data types.
      #   These types can be objects, but also primitives and arrays. This object is an extended subset of the JSON Schema Specification Wright Draft 00.
      class Schema < SchemaBase
        fields :title, :type, :description, :format, :default
        fields :multipleOf, :maximum, :exclusiveMaximum, :minimum, :exclusiveMinimum, :maxLength, :minLength
        fields :pattern, :maxItems, :minItems, :uniqueItems
        fields :maxProperties, :minProperties, :required, :enum

        array_field_block :allOf, :allOfItem, Yori::Schema::V3::Schema
        array_field_block :oneOf, :oneOfItem, Yori::Schema::V3::Schema
        array_field_block :anyOf, :anyOfItem, Yori::Schema::V3::Schema
        array_field_block :not, :notItem, Yori::Schema::V3::Schema

        field_block :items, Yori::Schema::V3::Schema
        hash_field_block :properties, :property, Yori::Schema::V3::Schema
        field_block :additionalProperties, Yori::Schema::V3::Schema

        fields :nullable, :readOnly, :writeOnly, :deprecated
        field_block :discriminator, Yori::Schema::V3::Discriminator
        field_block :xml, Yori::Schema::V3::XML
        field_block :externalDocs, Yori::Schema::V3::ExternalDocumentation
        field_block :example, Yori::Schema::Any
      end
    end
  end
end
