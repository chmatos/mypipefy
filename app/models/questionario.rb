# frozen_string_literal: true

class Questionario < ApplicationRecord
  self.table_name = 'questionario'

  has_many :questionario_perguntas
end