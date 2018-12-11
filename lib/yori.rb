require "yori/version"
require 'yori/schema_validator'
require "yori/schema_base"
require "yori/schema/any"

Dir[File.dirname(__FILE__) + '/yori/errors/*.rb'].each { |f| require f }

# Yori: Yet another Openapi Ruby Implementation
module Yori
  class << self
    def v3
      require 'yori/schema/v3'
      Yori::Schema::V3
    end
  end
end
