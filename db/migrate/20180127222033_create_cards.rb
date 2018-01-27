class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards, id: false do |t|
      t.integer :id, primary_key: true
      t.string :title
      t.datetime :created_at
      t.datetime :due_date
      t.references :phase, foreign_key: true
    end
  end
end
