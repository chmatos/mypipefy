# frozen_string_literal: true

class ProductDecorator < ApplicationDecorator
  delegate_all

  def thumb_product_image
    object.product_image.thumb.url || object.image_icon
  end

  def small_product_image
    object.product_image.small.url || object.image_icon
  end

  def custom_company_name
    @custom_company_name ||= object.fab_nome.present? ? object.fab_nome : object.nome
  end

  def custom_company_url
    @custom_company_url ||= object.fab_url.present? ? object.fab_url : object.url
  end

  def average_note_recommendation
    ((questionario_respostas.approved.rated_questions.recommendation_question.sum(:resposta).to_f / questionario_respostas.approved.rated_questions.recommendation_question.count) / 2).round(1)
  end

  def average_note_ease_use
    (questionario_respostas.approved.rated_questions.ease_use_question.sum(:resposta).to_f / questionario_respostas.approved.rated_questions.ease_use_question.count).round(1)
  end

  def average_note_client_support
    (questionario_respostas.approved.rated_questions.client_support_question.sum(:resposta).to_f / questionario_respostas.approved.rated_questions.client_support_question.count).round(1)
  end

  def average_note_cost_benefit
    (questionario_respostas.approved.rated_questions.cost_benefit_question.sum(:resposta).to_f / questionario_respostas.approved.rated_questions.cost_benefit_question.count).round(1)
  end

  def average_note_functionality
    (questionario_respostas.approved.rated_questions.functionality_question.sum(:resposta).to_f / questionario_respostas.approved.rated_questions.functionality_question.count).round(1)
  end
end
