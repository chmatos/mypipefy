# frozen_string_literal: true

class CreateCategoriaProduto < ActiveRecord::Migration[5.1]
  def change
    unless table_exists?(:categoria_produto)
      create_table :categoria_produto, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=latin1' do |t|
        t.bigint :categoria_id, null: false
        t.bigint :produto_id, null: false
        t.string :status, limit: 1, default: 'A'

        t.timestamps null: false

        t.index [:categoria_id], name: :fk_categ_idx
        t.index [:produto_id], name: :fk_prod_idx
      end
    end
  end
end
