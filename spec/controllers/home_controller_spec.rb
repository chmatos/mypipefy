# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController do

  describe 'GET #fetch_new_data' do
    before do
      get :fetch_new_data
    end

    it do
      expect(Organization.first.id).to eq(92_858)
      expect(Organization.first.pipes.first.id).to eq(335_557)
      expect(Organization.first.pipes.first.phases.first.id).to eq(2_343_216)
    end
  end

end
