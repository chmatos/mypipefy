class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations, id: false do |t|
      t.integer :id, primary_key: true
      t.string :name
      t.datetime :created_at
    end
  end
end
