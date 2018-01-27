# frozen_string_literal: true

class Phase < ApplicationRecord
  belongs_to :pipe
  has_many :cards
end
