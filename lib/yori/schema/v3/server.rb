# frozen_string_literal: true

require 'yori/schema/v3/server_variable'

module Yori
  module Schema
    module V3
      # Server: An object representing a Server.
      # @url: REQUIRED. A URL to the target host.
      #   This URL supports Server Variables and MAY be relative, to indicate that the host location is relative to the location where the OpenAPI document is being served.
      #   Variable substitutions will be made when a variable is named in {brackets}.
      # @description: An optional string describing the host designated by the URL. CommonMark syntax MAY be used for rich text representation.
      # @variables: A map between a variable name and its value. The value is used for substitution in the server's URL template.
      class Server < Yori::SchemaBase
        fields :url, :description
        hash_field_block :variables, :variable, Yori::Schema::V3::ServerVariable

        def validate!
          validate_require_fields!('url')
        end
      end
    end
  end
end
