# frozen_string_literal: true

class LandingPagesController < ApplicationController
  before_action :load_product_by_url, :authenticated_user?, only: [:new]

  include ProductQueries

  def index; end

  def new
    @questionario_produto ||= @product.questionario_produtos.active.first
    @assessment ||= Avaliacao.find_or_initialize_by(questionario_id: @questionario_produto.questionario_id, produto_id: @product.id, oauth_accounts_id: current_user.id)

    main_categories = Categoria.includes(:categorias).active.segment.order("nome")
    @main_categories = main_categories.map do |category|
      next if category.categorias.blank?
      [ "#{category.nome}", category.categorias.to_a.map(&:nome) ]
    end.uniq.compact!


    unless @assessment.questionario_respostas.count > 0
      @questionario_produto.questionario.questionario_perguntas.each do |pergunta|
        @assessment.questionario_respostas.build(questionario_pergunta: pergunta)
      end
    end
  end

  def thanks
    build_featured_products
    build_top_rated_products
  end

  def thanks; end
end
