# frozen_string_literal: true

class CreateCategoria < ActiveRecord::Migration[5.1]
  def change
    unless table_exists?(:categoria)
      create_table :categoria, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=latin1' do |t|
        t.string :nome, limit: 1000
        t.string :descricao, limit: 8000
        t.string :status, limit: 1, default: 'A'
        t.bigint :parent_id, default: 0
        t.string :tipo, limit: 200, default: 'categ'
        t.boolean :featured
        t.bigint :featured_position

        t.timestamps null: false
      end
    end
  end
end
