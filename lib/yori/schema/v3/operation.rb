# frozen_string_literal: true

require 'yori/schema/v3/external_documentation'
require 'yori/schema/v3/parameter'
require 'yori/schema/v3/request_body'
require 'yori/schema/v3/responses'
require 'yori/schema/v3/callback'
require 'yori/schema/v3/security_requirement'
require 'yori/schema/v3/server'

module Yori
  module Schema
    module V3
      # Operaion: Describes a single API operation on a path.
      class Operation < Yori::SchemaBase
        # @!method tags
        #   A list of tags for API documentation control.
        #   Tags can be used for logical grouping of operations by resources or any other qualifier.
        # @!method summary A short summary of what the operation does.
        # @!method description
        #   A verbose explanation of the operation behavior.
        #   CommonMark syntax MAY be used for rich text representation.
        # @!method operationId
        #   Unique string used to identify the operation. The id MUST be unique among all operations described in the API.
        #   Tools and libraries MAY use the operationId to uniquely identify an operation,
        #   therefore, it is RECOMMENDED to follow common programming naming conventions.
        # @!method deprecated
        #   Declares this operation to be deprecated. Consumers SHOULD refrain from usage of the declared operation.
        #   Default value is false.
        fields :tags, :summary, :description, :operationId, :deprecated
        # @!method externalDocs
        #   Additional external documentation for this operation.
        field_block :externalDocs, Yori::Schema::V3::ExternalDocumentation
        # @!method parameters
        #   A list of parameters that are applicable for this operation.
        #   If a parameter is already defined at the Path Item, the new definition will override it but can never remove it.
        #   The list MUST NOT include duplicated parameters. A unique parameter is defined by a combination of a name and location.
        #   The list can use the Reference Object to link to parameters that are defined at the OpenAPI Object's components/parameters.
        array_field_block :parameters, :parameter, Yori::Schema::V3::Parameter
        # @!method requestBody
        #   The request body applicable for this operation.
        #   The requestBody is only supported in HTTP methods where the HTTP 1.1 specification RFC7231 has explicitly defined semantics for request bodies.
        #   In other cases where the HTTP spec is vague, requestBody SHALL be ignored by consumers.
        field_block :requestBody, Yori::Schema::V3::RequestBody
        # @!method responses
        #   REQUIRED. The list of possible responses as they are returned from executing this operation.
        field_block :responses, Yori::Schema::V3::Responses
        # @!method callbacks
        #   A map of possible out-of band callbacks related to the parent operation.
        #   The key is a unique identifier for the Callback Object.
        #   Each value in the map is a Callback Object that describes a request that may be initiated by the API provider and the expected responses.
        #   The key value used to identify the callback object is an expression, evaluated at runtime, that identifies a URL to use for the callback operation.
        hash_field_block :callbacks, :callback, Yori::Schema::V3::Callback
        # @!method security
        #   A declaration of which security mechanisms can be used for this operation.
        #   The list of values includes alternative security requirement objects that can be used.
        #   Only one of the security requirement objects need to be satisfied to authorize a request.
        #   This definition overrides any declared top-level security.
        #   To remove a top-level security declaration, an empty array can be used.
        array_field_block :security, :schemes, Yori::Schema::V3::SecurityRequirement
        # @!method servers
        #   An alternative server array to service this operation.
        #   If an alternative server object is specified at the Path Item Object or Root level, it will be overridden by this value.
        array_field_block :servers, :server, Yori::Schema::V3::Server

        def validate!
          validate_require_fields!('responses')
        end
      end
    end
  end
end
