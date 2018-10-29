# frozen_string_literal: true

FactoryBot.define do
  factory :avaliacao do
    status 'P'
    produto
    oauth_account
    questionario
  end
end
