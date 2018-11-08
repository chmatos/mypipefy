# frozen_string_literal: true

class SearchController < ApplicationController
  protect_from_forgery except: :create

  before_action :index, only: [:show]
  skip_before_action :check_request_url

  respond_to :json, :html

  def index
    @result = []
    keyword_slug = params[:q]
    if keyword_slug.strip.present?
      keyword = keyword_slug.tr('-', ' ')
      unless keyword.empty?
        keyword = keyword.downcase
        @categ = Categoria
                 .order('nome ASC')
                 .where("status='A' and ifnull(tipo,'')='categ' and lower(nome) LIKE LOWER(?)", "%#{keyword}%")
                 .select("id , nome, 'CATEGORIA' as `group`, LOWER(replace(nome,' ','-')) as slug").first(5)
        @categ.map { |c| c.slug = c.slug.parameterize }

        @prod = Produto
                .order('nome ASC')
                .where("status='A' and lower(nome) LIKE LOWER(?)", "%#{keyword}%")
                .select("id , nome, 'PRODUTO' as `group`,LOWER(replace(nome,' ','-')) as slug").first(5)
        @prod.map { |p| p.slug = p.slug.parameterize }

        @result = @categ + @prod
      end
    end
    render json: @result
  end
end
