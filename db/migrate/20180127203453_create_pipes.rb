class CreatePipes < ActiveRecord::Migration[5.1]
  def change
    create_table :pipes, id: false do |t|
      t.integer :id, primary_key: true
      t.string :name
      t.references :organization
    end
  end
end
