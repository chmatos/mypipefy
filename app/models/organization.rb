# frozen_string_literal: true

class Organization < ApplicationRecord
  def self.store(organization: nil)
    return if organization.blank?
    org = Organization.find_or_initialize_by(id: organization['id'])
    org.update(id: organization['id'], name: organization['name'], created_at: organization['created_at'])
  end
end
