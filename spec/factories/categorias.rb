# frozen_string_literal: true

FactoryBot.define do
  factory :categoria do
    nome
    status 'A'
    parent_id 0
    tipo 'categ'
  end
end
