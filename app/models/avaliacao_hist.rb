# frozen_string_literal: true
class AvaliacaoHist < ApplicationRecord
  self.table_name = 'avaliacao_hist'

  belongs_to :produto
end
