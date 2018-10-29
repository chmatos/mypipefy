# frozen_string_literal: true

class CreateQuestionario < ActiveRecord::Migration[5.1]
  def change
    unless table_exists?(:questionario)
      create_table :questionario, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=latin1' do |t|
        t.string :nome, limit: 1000
        t.string :descricao, limit: 8000
        t.string :status, limit: 1, default: 'A'

        t.timestamps null: false
      end
    end
  end
end
