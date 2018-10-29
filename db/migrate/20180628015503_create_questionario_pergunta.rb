# frozen_string_literal: true

class CreateQuestionarioPergunta < ActiveRecord::Migration[5.1]
  def change
    unless table_exists?(:questionario_pergunta)
      create_table :questionario_pergunta, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=latin1' do |t|
        t.bigint :questionario_id, null: false
        t.text :pergunta, null: false
        t.integer :sequencia
        t.integer :pagina
        t.string :tipo_resposta, null: false
        t.text :opcoes
        t.string :status, limit: 1, default: 'A'
        t.integer :obrigatorio, default: 0
        t.string :info, limit: 8000

        t.timestamps null: false

        t.index [:questionario_id], name: :fk_quest_perg_quest_idx
      end
    end
  end
end
