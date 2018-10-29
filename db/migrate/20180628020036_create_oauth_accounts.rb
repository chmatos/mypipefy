# frozen_string_literal: true

class CreateOauthAccounts < ActiveRecord::Migration[5.1]
  def change
    unless table_exists?(:oauth_accounts)
      create_table :oauth_accounts, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin' do |t|
        t.string :provider
        t.string :uid
        t.string :image_url
        t.string :name
        t.string :email
        t.string :headline
        t.string :industry
        t.string :profile_url
        t.string :access_token
        t.text :raw_data, limit: 16_777_215
        t.integer :adm, default: 0
        t.timestamps null: false
      end
    end
  end
end
