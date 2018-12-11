# frozen_string_literal: true

require 'yori/schema/v3/contact'
require 'yori/schema/v3/license'

module Yori
  module Schema
    module V3
      # Info: The object provides metadata about the API. The metadata MAY be used by the clients if needed, and MAY be presented in editing or documentation generation tools for convenience.
      # @title: REQUIRED. The title of the application.
      # @description: A short description of the application. CommonMark syntax MAY be used for rich text representation.
      # @termsOfService: A URL to the Terms of Service for the API. MUST be in the format of a URL.
      # @contact: The contact information for the exposed API.
      # @license: The license information for the exposed API.
      # @version: REQUIRED. The version of the OpenAPI document (which is distinct from the OpenAPI Specification version or the API implementation version).
      class Info < Yori::SchemaBase
        fields :title, :description, :termsOfService, :version
        field_block :contact, Yori::Schema::V3::Contact
        field_block :license, Yori::Schema::V3::License

        def validate!
          validate_require_fields!('title', 'version')
        end
      end
    end
  end
end
