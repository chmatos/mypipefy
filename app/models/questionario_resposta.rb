# frozen_string_literal: true

class QuestionarioResposta < ApplicationRecord
  self.table_name = 'questionario_resposta'

  belongs_to :avaliacao
  belongs_to :questionario_pergunta

  scope :approved, -> { joins(:avaliacao).where(avaliacao: { status: 'A' } ) }
  scope :with_question, -> { joins(:questionario_pergunta) }
  scope :rated_questions, -> { with_question.where('questionario_pergunta.tipo_resposta LIKE ?', '%-rating%') }
  scope :text_questions, -> { with_question.where("questionario_pergunta.tipo_resposta = ?", 'text') }
  scope :recommendation_question, -> { with_question.where(questionario_pergunta: 1) }
  scope :ease_use_question, -> { with_question.where(questionario_pergunta: 3) }
  scope :client_support_question, -> { with_question.where(questionario_pergunta: 4) }
  scope :cost_benefit_question, -> { with_question.where(questionario_pergunta: 5) }
  scope :functionality_question, -> { with_question.where(questionario_pergunta: 6) }

  def custom_answer
    questionario_pergunta.pergunta.include?('recomendaria') ? resposta.to_f / 2 : resposta
  end
end
