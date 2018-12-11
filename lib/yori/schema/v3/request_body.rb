# frozen_string_literal: true

require 'yori/schema/v3/media_type'

module Yori
  module Schema
    module V3
      # RequestBody: Describes a single request body.
      class RequestBody < Yori::SchemaBase
        # @!method description
        #   A brief description of the request body. This could contain examples of use.
        #   CommonMark syntax MAY be used for rich text representation.
        # @!method required
        #   Determines if the request body is required in the request. Defaults to false.
        fields :description, :required
        # @!method content
        #   REQUIRED. The content of the request body. The key is a media type or media type range and the value describes it.
        #   For requests that match multiple keys, only the most specific key is applicable. e.g. text/plain overrides text/*
        hash_field_block :content, :content_type, Yori::Schema::V3::MediaType

        def validate!
          validate_require_fields!('content')
        end
      end
    end
  end
end
