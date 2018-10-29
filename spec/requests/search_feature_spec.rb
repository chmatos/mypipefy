# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search Workflow', type: :feature, js: true do
  context 'Product Test' do
    before do
      create(:produto, nome: 'Garmin Connect')
    end

    context 'with valid products' do
      it do
        visit root_path

        fill_in 'search_input', with: 'Garmin'
        expect(page).to have_content('Garmin Connect')
      end
    end
  end
end
