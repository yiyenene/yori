# frozen_string_literal: true

require 'yori/schema/v3/header'
require 'yori/schema/v3/media_type'
require 'yori/schema/v3/link'

module Yori
  module Schema
    module V3
      # Response: Describes a single response from an API Operation, including design-time, static links to operations based on the response.
      class Response < Yori::SchemaBase
        # @!method description
        #   REQUIRED. A short description of the response. CommonMark syntax MAY be used for rich text representation.
        fields :description
        # @!method headers
        #   Maps a header name to its definition. RFC7230 states header names are case insensitive.
        #   If a response header is defined with the name "Content-Type", it SHALL be ignored.
        hash_field_block :headers, :header, Yori::Schema::V3::Header
        # @!method content
        #   A map containing descriptions of potential response payloads. The key is a media type or media type range and the value describes it.
        #   For responses that match multiple keys, only the most specific key is applicable. e.g. text/plain overrides text/*
        hash_field_block :content, :content_type, Yori::Schema::V3::MediaType
        # @!method links
        #   A map of operations links that can be followed from the response.
        #   The key of the map is a short name for the link, following the naming constraints of the names for Component Objects.
        hash_field_block :links, :link, Yori::Schema::V3::Link

        def validate!
          validate_require_fields!('description')
        end
      end
    end
  end
end
