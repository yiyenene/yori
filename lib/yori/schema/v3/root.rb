# frozen_string_literal: true

module Yori
  module Schema
    module V3
      # Root
      module Root
        def self.included(klass)
          klass.class_eval do
            class << self
              def api_docs_factory
                @_api_docs_factory
              end

              def api_docs
                return unless api_docs_factory

                openapi = api_docs_factory.call
                openapi.to_json
              end

              def root(id = '', &block)
                @_api_docs_factory = proc do
                  Yori::Schema::V3::OpenAPI.new.tap do |openapi|
                    openapi.id = id
                    openapi.instance_eval(&block)
                  end
                end
              end
            end
          end
        end

        def api_docs
          self.class.api_docs
        end
      end
    end
  end
end
