# frozen_string_literal: true

require 'yori/schema/v3/schema'
require 'yori/schema/v3/example'
require 'yori/schema/v3/media_type'

module Yori
  module Schema
    module V3
      # Parameter: Describes a single operation parameter.
      class Parameter < Yori::SchemaBase
        fields :name, :description, :required, :deprecated, :allowEmptyValue

        def in_query
          self['in'] = 'query'
        end

        def in_header
          self['in'] = 'header'
        end

        def in_path
          self['in'] = 'path'
        end

        def in_cookie
          self['in'] = 'cookie'
        end

        fields :style, :explode, :allowReserved
        field_block :schema, Yori::Schema::V3::Schema

        def example_any(value)
          self['example'] = value
        end

        hash_field_block :examples, :example, Yori::Schema::V3::Example
        hash_field_block :content, :content_type, Yori::Schema::V3::MediaType

        def validate!
          validate_require_fields!('name', 'in')
          validate_in!
          validate_schema_or_content!
        end

        def validate_in!
          validate_limit_field_values!('in', 'query', 'header', 'path', 'cookie')
          in_value = self['in']

          case in_value
          when 'path'
            validate_require_fields!('required')
            validate_limit_field_values!('required', true)
          end
        end

        def validate_schema_or_content!
          validate_mutually_exclusive_fields!('schema', 'content')
        end
      end
    end
  end
end
