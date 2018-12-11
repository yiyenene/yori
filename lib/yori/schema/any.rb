# frozen_string_literal: true

module Yori
  module Schema
    # Any: supports any keyword as dsl.
    class Any < Yori::SchemaBase
      def respond_to_missing?(*)
        true
      end

      def method_missing(name, *args, &block)
        arg = args.first
        if arg || block_given?
          c = self.class.eval_input!(self.class, arg, &block)
          self[name.to_s] = c
          return self
        end
        super
      end
    end
  end
end
