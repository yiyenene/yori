# frozen_string_literal: true

require 'yori/schema/v3/components'
require 'yori/schema/v3/paths'

module Yori
  module Schema
    module V3
      # Provides register_component method
      class Composer
        def initialize(id)
          @id = id
        end

        attr_reader :id

        Yori::Schema::V3::Components::VALID_COMPONENTS.each do |component|
          define_method(component) do |key, value = nil, &block|
            Yori::Schema::V3::Components.register_component(id, component, key, value, &block)
          end
        end

        def path(key, value = nil, &block)
          Yori::Schema::V3::Paths.register_path(id, key, value, &block)
        end

        class << self
          def register(id = '', &block)
            composer = new(id)
            composer.instance_eval(&block)
          end
        end
      end
    end
  end
end
