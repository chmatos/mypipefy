# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    let(:category_01) { create(:categoria) }
    let(:category_02) do
      create(
        :categoria,
        parent_id: category_01.id
      )
    end
    let(:category_03) { create(:categoria, status: 'P') }

    before do
      category_01.produtos << create(:produto)
      category_03.produtos << create(:produto)
      get :index
    end

    it do
      expect(assigns(:categories)).to include(category_01)
      expect(assigns(:categories)).not_to include(category_02)
      expect(assigns(:categories)).not_to include(category_03)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:category) { create(:categoria, nome: 'test-name') }
    let!(:product01) { create(:produto, status: 'A', categorias: [category]) }
    let!(:product02) { create(:produto, status: 'P', categorias: [category]) }

    before do
      get :show, params: { url: 'test-name' }
    end

    it do
      expect(response).to have_http_status(:success)
      expect(assigns(:category).featured_products).to include(product01)
      expect(assigns(:category).featured_products).not_to include(product02)
      expect(assigns(:products)).not_to include(product02)
    end
  end
end
