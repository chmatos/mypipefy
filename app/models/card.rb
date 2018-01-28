# frozen_string_literal: true

class Card < ApplicationRecord
  belongs_to :phase
  has_many :fields
end
