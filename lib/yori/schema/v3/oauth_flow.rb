# frozen_string_literal: true

module Yori
  module Schema
    module V3
      # OAuthFlow: Configuration details for a supported OAuth Flow
      class OAuthFlow < Yori::SchemaBase
        # @!method authorizationUrl
        #   REQUIRED. The authorization URL to be used for this flow. This MUST be in the form of a URL.
        # @!method tokenUrl
        #   REQUIRED. The token URL to be used for this flow. This MUST be in the form of a URL.
        # @!method refreshUrl
        #   The URL to be used for obtaining refresh tokens. This MUST be in the form of a URL.
        fields :authorizationUrl, :tokenUrl, :refreshUrl

        # @!method scopes
        #   REQUIRED. The available scopes for the OAuth2 security scheme.
        #   A map between the scope name and a short description for it.
        def scopes(&block)
          self['scopes'] = {}
          instance_eval(&block)
        end

        def scope(key, value)
          self['scopes'] ||= {}
          self['scopes'][key.to_s] = value.to_s
        end

        def validate!
          validate_require_fields!('scopes')
        end
      end
    end
  end
end
