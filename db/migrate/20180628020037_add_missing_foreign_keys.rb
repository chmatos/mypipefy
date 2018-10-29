# frozen_string_literal: true

class AddMissingForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key(:avaliacao, :oauth_accounts, column: :oauth_accounts_id, name: :fk_aval_oauth_accounts) unless foreign_key_exists?(:avaliacao, name: :fk_aval_oauth_accounts)
    add_foreign_key(:avaliacao, :oauth_accounts, column: :oauth_accounts_id_adm, name: :fk_aval_oauth_accounts_adm) unless foreign_key_exists?(:avaliacao, name: :fk_aval_oauth_accounts_adm)
    add_foreign_key(:avaliacao, :produto, name: :fk_aval_prod) unless foreign_key_exists?(:avaliacao, name: :fk_aval_prod)
    add_foreign_key(:avaliacao, :questionario, name: :fk_aval_quest) unless foreign_key_exists?(:avaliacao, name: :fk_aval_quest)
    add_foreign_key(:avaliacao_hist, :avaliacao, name: :fk_aval_hist_aval_idx) unless foreign_key_exists?(:avaliacao_hist, name: :fk_aval_hist_aval_idx)
    add_foreign_key(:avaliacao_hist, :oauth_accounts, column: :oauth_accounts_id, name: :fk_aval_hist_oauth_accounts) unless foreign_key_exists?(:avaliacao_hist, name: :fk_aval_hist_oauth_accounts)
    add_foreign_key(:avaliacao_hist, :oauth_accounts, column: :oauth_accounts_id_adm, name: :fk_aval_hist_oauth_accounts_adm) unless foreign_key_exists?(:avaliacao_hist, name: :fk_aval_hist_oauth_accounts_adm)
    add_foreign_key(:avaliacao_hist, :produto, name: :fk_aval_hist_prod) unless foreign_key_exists?(:avaliacao_hist, name: :fk_aval_hist_prod)
    add_foreign_key(:avaliacao_hist, :questionario, name: :fk_aval_hist_quest) unless foreign_key_exists?(:avaliacao_hist, name: :fk_aval_hist_quest)
    add_foreign_key(:categoria_produto, :categoria, column: :categoria_id, name: :fk_categ) unless foreign_key_exists?(:categoria_produto, name: :fk_categ)
    add_foreign_key(:categoria_produto, :produto, name: :fk_prod) unless foreign_key_exists?(:categoria_produto, name: :fk_prod)
    add_foreign_key(:questionario_pergunta, :questionario, name: :fk_quest_perg_quest) unless foreign_key_exists?(:questionario_pergunta, name: :fk_quest_perg_quest)
    add_foreign_key(:questionario_produto, :produto, name: :fk_prod_quest_prod) unless foreign_key_exists?(:questionario_produto, name: :fk_prod_quest_prod)
    add_foreign_key(:questionario_produto, :questionario, name: :fk_quest_quest) unless foreign_key_exists?(:questionario_produto, name: :fk_quest_quest)
    add_foreign_key(:questionario_resposta, :questionario_pergunta, column: :questionario_pergunta_id, name: :fk_quest_resp_quest_perg_idx) unless foreign_key_exists?(:questionario_resposta, name: :fk_quest_resp_quest_perg_idx)
  end
end
