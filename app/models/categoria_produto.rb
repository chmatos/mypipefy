# frozen_string_literal: true

class CategoriaProduto < ApplicationRecord
  self.table_name = 'categoria_produto'

  belongs_to :categoria
  belongs_to :produto
end
