# frozen_string_literal: true

class CreateQuestionarioProduto < ActiveRecord::Migration[5.1]
  def change
    unless table_exists?(:questionario_produto)
      create_table :questionario_produto, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=latin1' do |t|
        t.bigint :questionario_id, null: false
        t.bigint :produto_id, null: false
        t.string :status, limit: 1, default: 'A'

        t.timestamps null: false

        t.index [:produto_id], name: :fk_prod_quest_idx
        t.index [:questionario_id], name: :fk_quest_quest_idx
      end
    end
  end
end
