# frozen_string_literal: true

class Avaliacao < ApplicationRecord
  self.table_name = 'avaliacao'

  # Status possíveis
  # AP - aguardando aprovacao - depois do usuario enviar e passar pela validacao do form
  # P - pendente - enquanto o usuario esta digitando e ainda nao enviou - como um carrinho de compras perdido
  # R - revisao - quando o admin recusa uma avaliacao em AP
  # A - aprovada - quando o admin aceita uma avaliacao AP

  belongs_to :produto, counter_cache: true
  belongs_to :oauth_account, foreign_key: :oauth_accounts_id
  belongs_to :questionario
  has_many :questionario_respostas
  has_many :questionario_perguntas, through: :questionario_respostas
  has_many :avaliacao_hists, dependent: :destroy, class_name: 'AvaliacaoHist'

  validates :status, :produto_id, :questionario_id, :oauth_accounts_id, presence: true

  scope :active, -> { where(status: 'A') }
  scope :pending, -> { where(status: 'AP') }
  scope :with_oauth_account, -> { includes(:oauth_account) }
  scope :with_answers, -> { includes(questionario_respostas: [:questionario_pergunta] ) }
  scope :newer, -> { order('created_at DESC') }

  accepts_nested_attributes_for :questionario_respostas, allow_destroy: true
end
