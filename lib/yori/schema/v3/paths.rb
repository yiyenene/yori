# frozen_string_literal: true

require 'yori/schema/v3/path_item'

module Yori
  module Schema
    module V3
      # Paths
      #   Holds the relative paths to the individual endpoints and their operations.
      #   The path is appended to the URL from the Server Object in order to construct the full URL.
      #   The Paths MAY be empty, due to ACL constraints.
      class Paths < Yori::SchemaBase
        # @!method path
        #   A relative path to an individual endpoint. The field name MUST begin with a slash.
        #   The path is appended (no relative URL resolution) to the expanded URL from the Server Object's url field in order to construct the full URL.
        #   Path templating is allowed. When matching URLs, concrete (non-templated) paths would be matched before their templated counterparts.
        #   Templated paths with the same hierarchy but different templated names MUST NOT exist as they are identical.
        #   In case of ambiguous matching, it's up to the tooling to decide which one to use.
        def path(path_temp, value = nil, &block)
          path_temp = '/' + path_temp unless path_temp.start_with?('/')
          self[path_temp] = self.class.eval_input!(Yori::Schema::V3::PathItem, value, &block)
        end

        def merge_registered!
          self.class.registered_path.each do |_path, block|
            instance_eval(&block)
          end
        end

        class << self
          attr_reader :registered_path

          def register_path(path, value = nil, &block)
            @registered_path ||= {}
            @registered_path[path] = proc { path(path, value, &block) }
          end
        end
      end
    end
  end
end
