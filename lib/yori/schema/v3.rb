# frozen_string_literal: true

module Yori
  module Schema
    # OpenApi version 3.0.0
    module V3
      Dir[File.dirname(__FILE__) + '/v3/*.rb'].each { |f| require f }
    end
  end
end
