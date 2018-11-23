# frozen_string_literal: true

class Api::V1::RankingsController < Api::BaseController
  before_action :authenticate_application
  before_action :validate_category, only: [ :index ]

  respond_to :json

  def index
    ranking_service = RankingService.new(category_id: params[:category_id])

    api_render status: :ok, json: ranking_service.category
  end

  def show
    ranking_service = RankingService.new(product_id: params[:id])
    api_render status: :ok, json: ranking_service.product
  end

  private

  def validate_category
    api_render status: :bad_request, json: { error_msg: 'category_id required' } if params[:category_id].blank?
  end
end
