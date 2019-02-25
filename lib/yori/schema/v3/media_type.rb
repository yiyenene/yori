# frozen_string_literal: true

require 'yori/schema/v3/schema'
require 'yori/schema/v3/example'
require 'yori/schema/v3/encoding'

module Yori
  module Schema
    module V3
      # MediaType: Each Media Type Object provides schema and examples for the media type identified by its key.
      class MediaType < Yori::SchemaBase
        # @!method schema
        #   The schema defining the type used for the request body.
        field_block :schema, Yori::Schema::V3::Schema

        # @!method example_any
        #   Example of the media type. The example object SHOULD be in the correct format as specified by the media type.
        #   The example object is mutually exclusive of the examples object. Furthermore, if referencing a schema which contains an example,
        #   the example value SHALL override the example provided by the schema.
        def example_any(value)
          self['example'] = value
        end

        # @!method examples
        #   Examples of the media type. Each example object SHOULD match the media type and specified schema if present.
        #   The examples object is mutually exclusive of the example object. Furthermore, if referencing a schema which contains an example,
        #   the examples value SHALL override the example provided by the schema.
        hash_field_block :examples, :example, Yori::Schema::V3::Example
        # @!method encoding
        #   A map between a property name and its encoding information. The key, being the property name, MUST exist in the schema as a property.
        #   The encoding object SHALL only apply to requestBody objects when the media type is multipart or application/x-www-form-urlencoded.
        hash_field_block :encoding, :property, Yori::Schema::V3::Encoding
      end
    end
  end
end
