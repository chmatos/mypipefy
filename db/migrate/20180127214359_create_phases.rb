class CreatePhases < ActiveRecord::Migration[5.1]
  def change
    create_table :phases, id: false do |t|
      t.integer :id, primary_key: true
      t.string :name
      t.references :pipe, foreign_key: true

      t.timestamps
    end
  end
end
