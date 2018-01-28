# frozen_string_literal: true

class Field < ApplicationRecord
  belongs_to :phase
  belongs_to :card, optional: true
end
