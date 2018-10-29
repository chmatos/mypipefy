# frozen_string_literal: true

class QuestionarioProduto < ApplicationRecord
  self.table_name = 'questionario_produto'

  belongs_to :produto
  belongs_to :questionario

  has_many :questionario_perguntas, through: :questionario

  scope :active, -> { where(status: 'A') }
end