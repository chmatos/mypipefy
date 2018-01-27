# frozen_string_literal: true

class Pipe < ApplicationRecord
  belongs_to :organization
  has_many :phases
end
