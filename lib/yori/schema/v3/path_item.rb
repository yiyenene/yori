# frozen_string_literal: true

require 'yori/schema/v3/operation'
require 'yori/schema/v3/server'
require 'yori/schema/v3/parameter'

module Yori
  module Schema
    module V3
      # PathItem
      #   Describes the operations available on a single path.
      #   A Path Item MAY be empty, due to ACL constraints.
      #   The path itself is still exposed to the documentation viewer but they will not know which operations and parameters are available.
      class PathItem < Yori::SchemaBase
        # @!method summary
        #   An optional, string summary, intended to apply to all operations in this path.
        # @!method description
        #   An optional, string description, intended to apply to all operations in this path.
        #   CommonMark syntax MAY be used for rich text representation.
        fields :summary, :description

        # @!method get A definition of a GET operation on this path.
        # @!method put A definition of a PUT operation on this path.
        # @!method post A definition of a POST operation on this path.
        # @!method delete A definition of a DELETE operation on this path.
        # @!method options A definition of a OPTIONS operation on this path.
        # @!method head A definition of a HEAD operation on this path.
        # @!method patch A definition of a PATH operation on this path.
        # @!method trace A definition of a TRACE operation on this path.
        %i[get put post delete options head patch trace].each do |method|
          field_block method, Yori::Schema::V3::Operation
        end

        # @!method servers
        #   An alternative server array to service all operations in this path.
        array_field_block :servers, :server, Yori::Schema::V3::Server

        # @!method parameters
        #   A list of parameters that are applicable for all the operations described under this path.
        #   These parameters can be overridden at the operation level, but cannot be removed there.
        #   The list MUST NOT include duplicated parameters. A unique parameter is defined by a combination of a name and location.
        #   The list can use the Reference Object to link to parameters that are defined at the OpenAPI Object's components/parameters.
        array_field_block :parameters, :parameter, Yori::Schema::V3::Parameter
      end
    end
  end
end
