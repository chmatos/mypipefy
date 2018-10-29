# frozen_string_literal: true

class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads do |t|
      t.integer :oauth_account_id, foreign_key: true, type: :integer, index: true
      t.integer :produto_id, foreign_key: true, index: true

      t.timestamps
    end
  end
end
