# frozen_string_literal: true

class OauthAccount < ApplicationRecord

  has_many :approved_avaliacaos, foreign_key: :oauth_accounts_id_adm, dependent: :destroy, class_name: 'Avaliacao'
  has_many :avaliacao_hists, dependent: :destroy, class_name: 'AvaliacaoHist', foreign_key: :oauth_accounts_id
  has_many :avaliacaos, foreign_key: :oauth_accounts_id, dependent: :destroy
  has_many :leads, dependent: :destroy
  has_many :produtos

  after_create :send_new_account_email

  def first_name
    name.split(' ').first
  end

  private

  def send_new_account_email
    SparksMailer.novo_usuario(self).deliver_later!
  end

end
