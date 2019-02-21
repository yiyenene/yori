# frozen_string_literal: true

require 'yori/errors/invalid_schema_error'

module Yori
  module Errors
    class MissingRequiredFieldError < InvalidSchemaError; end
  end
end
