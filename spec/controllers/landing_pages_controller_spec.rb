# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LandingPagesController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    let!(:product) { create(:produto, :with_assessments, nome: 'testname') }
    let(:oauth_account) { FactoryBot.create(:oauth_account) }

    before do
      allow_any_instance_of(SparksMailer).to receive(:novo_usuario).and_return(true)
      session[:uid] = oauth_account.uid
      get :new, params: { url: 'testname' }
    end

    it do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #thanks' do
    before do
      get :thanks
    end

    it do
      expect(response).to render_template(:thanks)
    end
  end
end
