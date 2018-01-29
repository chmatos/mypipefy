# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @organization = Organization.find(92_858)
    @pipe = @organization.pipes.first
    @cards = @organization.cards.order(:id)
    phase_ids = @cards.pluck(:phase_id).uniq
    @fields = Field.where(phase_id: phase_ids).order('id desc').pluck(:key, :name).uniq
    # @fields = Field.all.order('id desc').pluck(:key,:name).uniq
  end

  def fetch_new_data
    organizations = PipefyService.new.fetch_organizations(ids: [92_858])
    PipefyService.new.store(organizations: organizations)
    redirect_to home_index_url
  end
end
