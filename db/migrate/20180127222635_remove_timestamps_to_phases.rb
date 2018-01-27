class RemoveTimestampsToPhases < ActiveRecord::Migration[5.1]
  def change
    remove_column :phases, :created_at, :datetime
    remove_column :phases, :updated_at, :datetime
  end
end
