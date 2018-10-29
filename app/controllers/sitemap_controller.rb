# frozen_string_literal: true

class SitemapController < ApplicationController
  respond_to :xml

  def index
    @products   = ProductDecorator.decorate_collection(Produto.active)
    @categories = CategoryDecorator.decorate_collection(Categoria.active)
  end
end
