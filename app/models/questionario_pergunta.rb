# frozen_string_literal: true

class QuestionarioPergunta < ApplicationRecord
  self.table_name = 'questionario_pergunta'

  scope :rating_questions, -> { where('tipo_resposta LIKE ?', '%-rating%') }
  scope :text_questions, -> { where('tipo_resposta LIKE ?', 'text') }

  def custom_question
    if pergunta.include?('recomenda')
      'recomendaria'
    elsif pergunta.include?('Recursos')
      'funcionalidades'
    else
      pergunta
    end
  end

  def required?
    obrigatorio == 1 ? true : false
  end
end
