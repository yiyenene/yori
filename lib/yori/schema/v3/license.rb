# frozen_string_literal: true

module Yori
  module Schema
    module V3
      # License: License information for the exposed API.
      # @name: REQUIRED. The license name used for the API.
      # @url: A URL to the license used for the API. MUST be in the format of a URL.
      class License < Yori::SchemaBase
        fields :name, :url

        def validate!
          validate_require_fields!('name')
        end
      end
    end
  end
end
