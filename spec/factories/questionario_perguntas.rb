# frozen_string_literal: true

FactoryBot.define do
  factory :questionario_pergunta do
    status 'A'
    pergunta 'A question?'
    tipo_resposta 'star-rating'
  end
end
