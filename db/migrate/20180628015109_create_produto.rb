# frozen_string_literal: true

class CreateProduto < ActiveRecord::Migration[5.1]
  def change
    unless table_exists?(:produto)
      create_table :produto, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=latin1' do |t|
        t.string :nome, limit: 1000
        t.string :descricao, limit: 8000
        t.string :image_banner
        t.string :image_icon
        t.string :status, limit: 1, default: 'A'
        t.string :fab_nome, limit: 1000
        t.string :fab_url, limit: 1000
        t.bigint :oauth_accounts_id
        t.string :oauth_accounts_id_adms, limit: 100
        t.string :url, limit: 1000
        t.string :tipo
        t.string :product_image
        t.string :ideal_profile, limit: 8000
        t.bigint :initial_price
        t.bigint :price_kind
        t.bigint :trial_kind
        t.string :trial_other_text
        t.boolean :access_web_navigation
        t.boolean :access_mobile_ios
        t.boolean :access_mobile_android
        t.boolean :access_desktop_pc
        t.boolean :access_desktop_apple
        t.boolean :access_desktop_linux
        t.bigint :support_hour_kind
        t.boolean :support_email
        t.boolean :support_chat
        t.boolean :support_phone
        t.boolean :training_video
        t.boolean :training_text
        t.boolean :training_presential
        t.boolean :training_ebook
        t.bigint :country_id
        t.bigint :start_year
        t.bigint :avaliacaos_count

        t.timestamps null: false
      end
    end
  end
end
