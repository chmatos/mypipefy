# frozen_string_literal: true

FactoryBot.define do
  sequence :nome do |n|
    "Nome de teste numero #{n}"
  end

  sequence :name do |n|
    "Test Name with number #{n}"
  end
end
