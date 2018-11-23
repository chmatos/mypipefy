# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RankingsController, type: :controller do
  describe "GET #show" do
    let(:product) { create(:produto) }

    before do
      request.headers.merge!(authenticated_header)
    end

    context "no id passed" do
      it "returns an empty hash" do
        get :show, params: { id: "" }

        expect(response.body).to eq("{}")
      end
    end
  end
end

def authenticated_header
  { 'Authorization': "Bearer test" }
end
