class CreateFields < ActiveRecord::Migration[5.1]
  def change
    create_table :fields do |t|
      t.string :key
      t.references :phase, null: true
      t.references :card, null: true
      t.string :name
    end
    add_index :fields, [:key, :phase_id], unique: true
  end
end
