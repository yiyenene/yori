# frozen_string_literal: true

require 'yori/schema/v3/oauth_flow'

module Yori
  module Schema
    module V3
      # OAuthFlows: Allows configuration of the supported OAuth Flows.
      class OAuthFlows < Yori::SchemaBase
        # @!method implicit
        #   Configuration for the OAuth Implicit flow
        field_block :implicit, Yori::Schema::V3::OAuthFlow
        # @!method password
        #   Configuration for the OAuth Resource Owner Password flow
        field_block :password, Yori::Schema::V3::OAuthFlow
        # @!method clientCredentials
        #   Configuration for the OAuth Client Credentials flow.
        #   Previously called application in OpenAPI 2.0.
        field_block :clientCredentials, Yori::Schema::V3::OAuthFlow
        # @!method authorizationCode
        #   Configuration for the OAuth Authorization Code flow.
        #   Previously called accessCode in OpenAPI 2.0.
        field_block :authorizationCode, Yori::Schema::V3::OAuthFlow

        def validate!
          %w[implicit clientCredentials authorizationCode].each do |field|
            validate_flow!(field)
          end
        end

        def validate_flow!(flow)
          oauth_flow = self[flow]
          oauth_flow&.validate_require_fields!(*required_flow_fields(flow))
        end

        def required_flow_fields(flow)
          case flow
          when 'implicit'
            %w[authorizationUrl]
          when 'clientCredentials'
            %w[tokenUrl]
          when 'authorizationCode'
            %w[authorizationUrl tokenUrl]
          else
            []
          end
        end
      end
    end
  end
end
