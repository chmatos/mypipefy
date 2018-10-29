# frozen_string_literal: true

class CreateAvaliacaoHist < ActiveRecord::Migration[5.1]
  def change
    unless table_exists?(:avaliacao_hist)
      create_table :avaliacao_hist, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=latin1' do |t|
        t.bigint :avaliacao_id
        t.bigint :produto_id
        t.bigint :questionario_id
        t.bigint :oauth_accounts_id
        t.string :status, limit: 2
        t.bigint :oauth_accounts_id_adm

        t.timestamps null: false

        t.index [:avaliacao_id], name: :fk_aval_hist_aval_idx
        t.index [:oauth_accounts_id], name: :fk_aval_hist_oauth_accounts_idx
        t.index [:oauth_accounts_id_adm], name: :fk_aval_hist_oauth_accounts_adm_idx
        t.index [:produto_id], name: :fk_aval_hist_prod_idx
        t.index [:questionario_id], name: :fk_aval_hist_quest_idx
      end
    end
  end
end
