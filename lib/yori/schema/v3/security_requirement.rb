# frozen_string_literal: true

module Yori
  module Schema
    module V3
      # SecurityRequirement:
      #   Lists the required security schemes to execute this operation.
      #   The name used for each property MUST correspond to a security scheme declared in the Security Schemes under the Components Object.
      class SecurityRequirement < Yori::SchemaBase
        # @!method scheme
        #   Each key MUST correspond to a security scheme which is declared in the Security Schemes under the Components Object.
        #   If the security scheme is of type "oauth2" or "openIdConnect", then the value is a list of scope names required for the execution.
        #   For other security scheme types, the array MUST be empty.
        def scheme(key, scopes)
          self[key.to_s] ||= []
          self[key.to_s].concat(scopes)
        end

        # TODO: validate with related SecurityScheme type...
      end
    end
  end
end
