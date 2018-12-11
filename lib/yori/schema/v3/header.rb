# frozen_string_literal: true

require 'yori/schema/v3/parameter'

module Yori
  module Schema
    module V3
      # Header: The Header Object follows the structure of the Parameter Object with the following changes:
      # 1. name MUST NOT be specified, it is given in the corresponding headers map.
      # 2. in MUST NOT be specified, it is implicitly in header.
      # 3. All traits that are affected by the location MUST be applicable to a location of header (for example, style).
      class Header < Yori::Schema::V3::Parameter
        def validate!
          %w[name in].each do |field|
            raise Yori::Errors::FieldMustNotBeSpecifiedError, "#{field} of Header Object." if key?(field)
          end
          validate_schema_or_content!
        end
      end

      # ref yori/schema/v3/encoding
      # partial definition to avoid circular reference.
      class Encoding < Yori::SchemaBase
        # @!method headers
        #   A map allowing additional information to be provided as headers, for example Content-Disposition.
        #   Content-Type is described separately and SHALL be ignored in this section.
        #   This property SHALL be ignored if the request body media type is not a multipart.
        hash_field_block :headers, :header, Yori::Schema::V3::Header
      end
    end
  end
end
