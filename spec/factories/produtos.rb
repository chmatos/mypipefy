# frozen_string_literal: true

FactoryBot.define do
  factory :produto do
    nome
    descricao 'aqui temos uma descricao com no mínimo 40 caracteres para funcionar'
    ideal_profile 'aqui temos um perfil ideal com no mínimo 40 caracteres para funcionar'
    initial_price 40.0
    price_kind 0
    trial_kind 0
    support_hour_kind 0
    url 'google.com'
    start_year 2010
    country
    tipo 1
    status 'A'
    product_image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'logo.png'), 'image/png') }

    trait :with_assessments do
      after(:create) do |instance|
      create_list(:questionario_produto, 1, produto: instance)
      end
    end
  end
end
