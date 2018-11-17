# frozen_string_literal: true

class Api::V1::RankingController < Api::V1::ApiController
  before_action do
    authenticate_application
  end

  respond_to :json

  def index
    api_render status: :bad_request, json: { error_msg: 'category_id required' } unless params[:category_id].present?
    rs = RankingService.new(category_id: params[:category_id])
    api_render status: :ok, json: rs.category
  end

  def show
    rs = RankingService.new(product_id: params[:id])
    api_render status: :ok, json: rs.product
  end
end
