# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SitemapController, type: :controller do
  describe 'GET #index' do
    let!(:valid_product) { create(:produto) }
    let!(:invalid_product) { create(:produto, status: 'B') }

    let!(:valid_category) { create(:categoria) }
    let!(:invalid_category) { create(:categoria, status: 'B') }

    it 'returns http success' do
      get :index, format: :xml
      expect(response).to have_http_status(:success)

      expect(response.body).to include('/categorias')

      expect(response.body).to include(valid_product.nome.parameterize)
      expect(response.body).not_to include(invalid_product.nome.parameterize)

      expect(response.body).to include(valid_category.nome.parameterize)
      expect(response.body).not_to include(invalid_category.nome.parameterize)
    end
  end
end
