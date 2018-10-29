# frozen_string_literal: true

class CreateAvaliacao < ActiveRecord::Migration[5.1]
  def change
    unless table_exists?(:avaliacao)
      create_table :avaliacao, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=latin1' do |t|
        t.bigint :produto_id
        t.bigint :questionario_id
        t.bigint :oauth_accounts_id
        t.bigint :oauth_accounts_id_adm
        t.string :status, limit: 2, default: 'P'

        t.timestamps

        t.index [:oauth_accounts_id], name: :fk_aval_oauth_accounts_idx
        t.index [:oauth_accounts_id_adm], name: :fk_aval_oauth_accounts_adm_idx
        t.index [:produto_id], name: :fk_aval_prod_idx
        t.index [:questionario_id], name: :fk_aval_quest_idx
      end
    end
  end
end
