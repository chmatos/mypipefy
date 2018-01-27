# frozen_string_literal: true

class HomeController < ApplicationController
  def index
  end

  def fetch_new_data
    organizations = PipefyService.new.fetch_organizations(ids: [92_858])
    puts organizations
    OrganizationService.new.store(organizations: organizations)
    redirect_to home_index_url
  end
end
