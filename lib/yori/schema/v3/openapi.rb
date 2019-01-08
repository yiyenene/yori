# frozen_string_literal: true

require 'yori/schema/v3/info'
require 'yori/schema/v3/server'
require 'yori/schema/v3/paths'
require 'yori/schema/v3/components'
require 'yori/schema/v3/security_requirement'
require 'yori/schema/v3/tag'
require 'yori/schema/v3/external_documentation'

module Yori
  module Schema
    module V3
      # OpenAPI
      #   This is the root document object of the OpenAPI document.
      class OpenAPI < Yori::SchemaBase
        # @!method openapi
        #   REQUIRED. This string MUST be the semantic version number of the OpenAPI Specification version that the OpenAPI document uses.
        #   The openapi field SHOULD be used by tooling specifications and clients to interpret the OpenAPI document.
        #   This is not related to the API info.version string.
        fields :openapi
        # @!method info
        #   REQUIRED. Provides metadata about the API.
        #   The metadata MAY be used by tooling as required.
        field_block :info, Yori::Schema::V3::Info
        # @!method servers
        #   An array of Server Objects, which provide connectivity information to a target server.
        #   If the servers property is not provided, or is an empty array, the default value would be a Server Object with a url value of /.
        array_field_block :servers, :server, Yori::Schema::V3::Server
        # @!method paths
        #   REQUIRED. The available paths and operations for the API.
        field_block :paths, Yori::Schema::V3::Paths

        # @!method components
        #   An element to hold various schemas for the specification.
        field_block :components, Yori::Schema::V3::Components

        # @!method security
        #   A declaration of which security mechanisms can be used across the API.
        #   The list of values includes alternative security requirement objects that can be used.
        #   Only one of the security requirement objects need to be satisfied to authorize a request.
        #   Individual operations can override this definition.
        array_field_block :security, :requirement, Yori::Schema::V3::SecurityRequirement
        # @!method tags
        #   A list of tags used by the specification with additional metadata.
        #   The order of the tags can be used to reflect on their order by the parsing tools.
        #   Not all tags that are used by the Operation Object must be declared.
        #   The tags that are not declared MAY be organized randomly or based on the tools' logic.
        #   Each tag name in the list MUST be unique.
        array_field_block :tags, :tag, Yori::Schema::V3::Tag
        # @!method externalDocs
        #   Additional external documentation.
        field_block :externalDocs, Yori::Schema::V3::ExternalDocumentation

        def validate!
          validate_require_fields!('openapi', 'info', 'paths')
        end
      end
    end
  end
end
