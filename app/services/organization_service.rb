# frozen_string_literal: true

class OrganizationService
  def initialize
  end

  def store(organizations: nil)
    binding.pry
    return if organizations.blank?

    organizations.each do |organization|
      Organization.create(id: organization['id'], name: organization['name'], created_at: organization['created_at'], pipes: organization['pipes'])
    end
  end
end
