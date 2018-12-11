# frozen_string_literal: true

require 'yori/schema/v3/components'

module Yori
  module Schema
    module V3
      # Provides register_component method
      module Composable
        def self.included(klass)
          klass.extend ClassMethods
        end

        module ClassMethods # rubocop:disable Style/Documentation
          private

          Yori::Schema::V3::Components::VALID_COMPONENTS.each do |component|
            define_method("register_#{component}") do |key, value = nil, &block|
              Yori::Schema::V3::Components.register_component(component, key, value, &block)
            end
          end
        end
      end
    end
  end
end
