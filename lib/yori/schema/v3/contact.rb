# frozen_string_literal: true

module Yori
  module Schema
    module V3
      # Contact: Contact information for the exposed API.
      # @name: The identifying name of the contact person/organization.
      # @url: The URL pointing to the contact information. MUST be in the format of a URL.
      # @email: The email address of the contact person/organization. MUST be in the format of an email address.
      class Contact < Yori::SchemaBase
        fields :name, :url, :email
      end
    end
  end
end
