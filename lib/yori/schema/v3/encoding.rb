# frozen_string_literal: true

module Yori
  module Schema
    module V3
      # Encoding: A single encoding definition applied to a single schema property.
      class Encoding < Yori::SchemaBase
        # @!method contentType
        #   The Content-Type for encoding a specific property.
        #   Default value depends on the property type:
        #   for string with format being binary - application/octet-stream;
        #   for other primitive types - text/plain; for object - application/json;
        #   for array - the default is defined based on the inner type.
        #   The value can be a specific media type (e.g. application/json), a wildcard media type (e.g. image/*), or a comma-separated list of the two types.
        # @!method style
        #   Describes how a specific property value will be serialized depending on its type.
        #   See Parameter Object for details on the style property. The behavior follows the same values as query parameters, including default values.
        #   This property SHALL be ignored if the request body media type is not application/x-www-form-urlencoded.
        # @!method explode
        #   When this is true, property values of type array or object generate separate parameters for each value of the array, or key-value-pair of the map. For other types of properties this property has no effect.
        #   When style is form, the default value is true. For all other styles, the default value is false.
        #   This property SHALL be ignored if the request body media type is not application/x-www-form-urlencoded.
        # @!method allowReserved
        #   Determines whether the parameter value SHOULD allow reserved characters, as defined by RFC3986 :/?#[]@!$&'()*+,;= to be included without percent-encoding. The default value is false.
        #   This property SHALL be ignored if the request body media type is not application/x-www-form-urlencoded.
        fields :contentType, :style, :explode, :allowReserved

        # headers are defined at yori/schema/v3/header.rb
        # to avoid circular reference.
      end
    end
  end
end
