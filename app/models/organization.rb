# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :pipes
  has_many :phases, through: :pipes
  has_many :cards, through: :phases
end
