# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    featured_categories = Categoria.active.main.featured
    @featured_categories = CategoryDecorator.decorate_collection(featured_categories)
    @categories = main_categories_list - featured_categories
  end

  def show
    @category = CategoryDecorator.decorate(Categoria.active.find_by_name(params[:url]))
    @featured_products = ProductDecorator.decorate_collection(@category.featured_products)
    @products = ProductDecorator.decorate_collection(@category.produtos.active.order(:nome) - @category.featured_products)
  end
end
