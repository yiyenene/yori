# frozen_string_literal: true

require 'yori/schema/v3/schema'
require 'yori/schema/v3/response'
require 'yori/schema/v3/parameter'
require 'yori/schema/v3/example'
require 'yori/schema/v3/request_body'
require 'yori/schema/v3/header'
require 'yori/schema/v3/security_scheme'
require 'yori/schema/v3/link'
require 'yori/schema/v3/callback'

module Yori
  module Schema
    module V3
      # Components
      #   Holds a set of reusable objects for different aspects of the OAS.
      #   All objects defined within the components object will have no effect on the API
      #   unless they are explicitly referenced from properties outside the components object.
      class Components < Yori::SchemaBase
        # @!method schemas An object to hold reusable Schema Objects.
        hash_field_block :schemas, :schema, Yori::Schema::V3::Schema
        # @!method responses An object to hold reusable Response Objects.
        hash_field_block :responses, :response, Yori::Schema::V3::Response
        # @!method parameters An object to hold reusable Parameter Objects.
        hash_field_block :parameters, :parameter, Yori::Schema::V3::Parameter
        # @!method examples An object to hold reusable Example Objects.
        hash_field_block :examples, :example, Yori::Schema::V3::Example
        # @!method requestBodies An object to hold reusable Request Body Objects.
        hash_field_block :requestBodies, :requestBody, Yori::Schema::V3::RequestBody
        # @!method headers An object to hold reusable Header Objects.
        hash_field_block :headers, :header, Yori::Schema::V3::Header
        # @!method securitySchemes An object to hold reusable Security Scheme Objects.
        hash_field_block :securitySchemes, :securityScheme, Yori::Schema::V3::SecurityScheme
        # @!method links An object to hold reusable Link Objects.
        hash_field_block :links, :link, Yori::Schema::V3::Link
        # @!method callbacks An object to hold reusable Callback Objects.
        hash_field_block :callbacks, :callback, Yori::Schema::V3::Callback

        def merge_registered!
          components = self.class.registered_components
          components.flat_map { |_component, procs| procs.values }
                    .each do |block|
                      instance_eval(&block)
                    end
        end

        VALID_COMPONENTS = %w[schema response parameter example requestBody header securityScheme link callback].freeze

        def check_and_send!(component, key, value, &block)
          raise Yori::Errors::UnknownComponentError, "Unknown component: #{component}" unless VALID_COMPONENTS.include?(component.to_s)
          send(component, key, value, &block)
        end

        class << self
          attr_reader :registered_components

          def register_component(component, key, value = nil, &block)
            @registered_components ||= {}
            @registered_components[component.to_s] ||= {}
            @registered_components[component.to_s][key.to_s] = proc { check_and_send!(component, key, value, &block) }
          end
        end
      end
    end
  end
end
