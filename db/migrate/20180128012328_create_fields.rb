class CreateFields < ActiveRecord::Migration[5.1]
  def change
    create_table :fields, id: false do |t|
      t.string :id, primary_key: true
      t.integer :phase_id, null: true
      t.integer :card_id, null: true
      t.string :name
    end
  end
end
