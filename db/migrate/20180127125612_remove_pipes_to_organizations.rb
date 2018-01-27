class RemovePipesToOrganizations < ActiveRecord::Migration[5.1]
  def change
    remove_column :organizations, :pipes, :jsonb
  end
end
