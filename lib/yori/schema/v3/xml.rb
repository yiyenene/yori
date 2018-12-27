# frozen_string_literal: true

module Yori
  module Schema
    module V3
      # Xml
      #   A metadata object that allows for more fine-tuned XML model definitions.
      #   When using arrays, XML element names are not inferred (for singular/plural forms) and the name property SHOULD be used to add that information.
      class XML < Yori::SchemaBase
        # @!method name
        #   Replaces the name of the element/attribute used for the described schema property.
        #   When defined within items, it will affect the name of the individual XML elements within the list.
        #   When defined alongside type being array (outside the items), it will affect the wrapping element and only if wrapped is true.
        #   If wrapped is false, it will be ignored.
        # @!method namespace
        #   The URI of the namespace definition. Value MUST be in the form of an absolute URI.
        # @!method prefix
        #   The prefix to be used for the name.
        # @!method attribute
        #   Declares whether the property definition translates to an attribute instead of an element. Default value is false.
        # @!method wrapped
        #   MAY be used only for an array definition. Signifies whether the array is wrapped (for example, <books><book/><book/></books>) or unwrapped (<book/><book/>).
        #   Default value is false. The definition takes effect only when defined alongside type being array (outside the items).
        fields :name, :namespace, :prefix, :attribute, :wrapped
      end
    end
  end
end
