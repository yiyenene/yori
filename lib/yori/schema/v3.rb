# frozen_string_literal: true

module Yori
  module Schema
    # OpenApi version 3.0.0
    module V3
      Dir[File.dirname(__FILE__) + '/v3/*.rb'].each { |f| require f }

      class << self
        attr_reader :api_docs_factory

        def api_docs
          return unless api_docs_factory
          openapi = api_docs_factory.call
          openapi.to_json
        end

        def root(&block)
          @api_docs_factory = proc do
            Yori::Schema::V3::OpenApi.new.tap do |openapi|
              openapi.instance_eval(&block)
            end
          end
        end
      end
    end
  end
end
