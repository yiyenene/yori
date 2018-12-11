# frozen_string_literal: true

require 'yori/schema/v3/external_documentation'

module Yori
  module Schema
    module V3
      # Tag
      #   Adds metadata to a single tag that is used by the Operation Object.
      #   It is not mandatory to have a Tag Object per tag defined in the Operation Object instances.
      class Tag < Yori::SchemaBase
        # @!method name
        #   REQUIRED. The name of the tag.
        # @!method description
        #   A short description for the tag.
        #   CommonMark syntax MAY be used for rich text representation.
        fields :name, :description
        # @!method externalDocs
        #   Additional external documentation for this tag.
        field_block :externalDocs, Yori::Schema::V3::ExternalDocumentation

        def validate!
          validate_require_fields!('name')
        end
      end
    end
  end
end
