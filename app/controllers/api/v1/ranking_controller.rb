# frozen_string_literal: true

class Api::V1::RankingController < Api::BaseController
  before_action do
    authenticate_application
  end

  respond_to :json

  def index
    api_render status: :bad_request, json: { error_msg: 'category_id required' } if params[:category_id].blank?
    rs = RankingService.new(category_id: params[:category_id])
    api_render status: :ok, json: rs.category
  end

  def show
    rs = RankingService.new(product_id: params[:id])
    api_render status: :ok, json: rs.product
  end
end
