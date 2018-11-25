# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RankingsController, type: :controller do
  before do
    request.headers.merge!({ 'Authorization': "Token token=#{ENV['TOKEN_API']}" })
  end

  describe "GET #show" do
    context "no id passed" do
      it "returns an empty hash" do
        get :show, params: { id: "" }

        expect(response.body).to eq("{}")
      end
    end

    context "with id passed" do
      let(:product) { create(:produto) }

      it "returns an hash" do
        get :show, params: { id: product.id }

        expect(response.body).to eq(
          {
            product_id: product.id,
            nome: product.nome,
            coordenadaX: 0.0,
            coordenadaY: 0.0,
            imagePath: "/uploads/small_logo.png"
          }.to_json
        )
      end
    end
  end

  describe "GET #index" do
    context "no id passed" do
      it "returns an empty hash" do
        get :index, params: { category_id: "" }
        expect(response.body).to eq({ error_msg: 'category_id required' }.to_json)
      end
    end

    context "with category_id passed" do
      let(:category) { create(:categoria) }
      let(:product_01) { create(:produto) }
      let(:product_02) { create(:produto) }

      let(:category) { create(:categoria, nome: 'Category Name') }
      let!(:product_01) { create(:produto, nome: 'Product 01 Name', categorias: [category]) }
      let!(:product_02) { create(:produto, nome: 'Product 02 Name', categorias: [category]) }

      it "returns an hash" do
        get :index, params: { category_id: category.id }
        expect(response.body).to eq(
          [
            {
              product_id: product_01.id,
              nome: 'Product 01 Name',
              coordenadaX: 0.0,
              coordenadaY: 0.0,
              imagePath: "/uploads/small_logo.png"
            },
            {
              product_id: product_02.id,
              nome: 'Product 02 Name',
              coordenadaX: 0.0,
              coordenadaY: 0.0,
              imagePath: "/uploads/small_logo.png"
            }
          ].to_json
        )
      end
    end
  end
end

