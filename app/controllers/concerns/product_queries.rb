# frozen_string_literal: true

module ProductQueries

  extend ActiveSupport::Concern

  def build_featured_products
    @featured_products = ProductDecorator.decorate_collection(Produto.active.order('avaliacaos_count DESC').take(18))
  end

  def build_top_rated_products
    @top_rated_products = ProductDecorator.decorate_collection(
      Produto.active.joins(questionario_respostas: [ :questionario_pergunta ]).group(:produto_id).order('AVG(questionario_resposta.resposta) DESC').where('questionario_resposta.questionario_pergunta_id = "1" AND questionario_pergunta.status = "A" AND questionario_resposta.status = "A"').take(9)
    )
  end
end

