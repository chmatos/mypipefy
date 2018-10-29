# frozen_string_literal: true

class CreateQuestionarioResposta < ActiveRecord::Migration[5.1]
  def change
    unless table_exists?(:questionario_resposta)
      create_table :questionario_resposta, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=latin1' do |t|
        t.bigint :avaliacao_id
        t.bigint :questionario_pergunta_id, null: false
        t.text :resposta, null: false
        t.string :status, limit: 1, default: 'A'

        t.timestamps null: false

        t.index [:questionario_pergunta_id], name: :fk_quest_resp_quest_perg_idx
      end
    end
  end
end
