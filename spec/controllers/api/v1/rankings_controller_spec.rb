# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RankingsController, type: :controller do
  before do
    request.headers.merge!(authenticated_header)
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

      it "returns an empty hash" do
        get :show, params: { id: product.id }

        expect(response.body).to eq(
          {
            product_id: product.id,
            nome: product.nome,
            coordenadaX: 0.0,
            coordenadaY: 0,
            imagePath: "/uploads/small_logo.png"
          }.to_json
        )
      end
    end
  end
end

