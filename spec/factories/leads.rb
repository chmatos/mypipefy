# frozen_string_literal: true

FactoryBot.define do
  factory :lead do
    oauth_account
    produto
  end
end
