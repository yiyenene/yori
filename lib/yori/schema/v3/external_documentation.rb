# frozen_string_literal: true

module Yori
  module Schema
    module V3
      # ExternalDocumentation: Allows referencing an external resource for extended documentation.
      # @description: A short description of the target documentation. CommonMark syntax MAY be used for rich text representation.
      # @url: REQUIRED. The URL for the target documentation. Value MUST be in the format of a URL.
      class ExternalDocumentation < Yori::SchemaBase
        fields :description, :url

        def validate!
          validate_require_fields!('url')
        end
      end
    end
  end
end
