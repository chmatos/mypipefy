class CreateValues < ActiveRecord::Migration[5.1]
  def change
    create_table :values do |t|
      t.string :key
      t.references :card
      t.references :phase
      t.string :content
    end
  end
end
