# frozen_string_literal: true

class Produto < ApplicationRecord
  self.table_name = 'produto'

  attr_accessor :product_image_width, :product_image_height

  belongs_to :country
  belongs_to :oauth_account, foreign_key: :oauth_accounts_id, optional: true
  belongs_to :oauth_account_adm, foreign_key: :oauth_accounts_id_adms, class_name: 'OauthAccount', optional: true

  has_many :avaliacao_hists
  has_many :avaliacaos, dependent: :destroy
  has_many :categoria_produtos, dependent: :destroy
  has_many :categorias, through: :categoria_produtos
  has_many :leads, dependent: :destroy
  has_many :questionario_produtos, dependent: :destroy
  has_many :questionario_respostas, through: :avaliacaos

  has_and_belongs_to_many :categorias

  validate :unique_name_validation
  validates :nome, presence: true, length: { minimum: 3 }
  validates :descricao, presence: true, length: { minimum: 40 }
  validates :terms_and_conditions, acceptance: true
  validates :ideal_profile, :initial_price, :price_kind, :url, :support_hour_kind,
    :trial_kind, :tipo, :product_image, :country_id, :start_year, presence: true

  enum price_kind: {monthly: 0, annual: 1}

  scope :active, -> { where(status: 'A') }
  scope :pending, -> { where(status: 'P') }

  mount_uploader :product_image, ProductImageUploader

  # TODO: Fix it. Does't work in production, only in dev
  #validate :product_image_format

  def self.find_by_name(name)
    product = find_by("LOWER(nome) = LOWER(replace('#{name}','-',' '))")
    product ||= (find_by("LOWER(replace(nome,' ','')) = LOWER(replace('#{name}','-',''))") ||
      find_by("LOWER(nome) = LOWER(replace('#{name}','-','.'))")
    )
    raise ActiveRecord::RecordNotFound if product.blank?
    product
  end

  def main_category
    categorias.where(parent_id: 0).first
  end

  def secondary_category
    categorias.where.not(parent_id: 0).first
  end

  def approved_assessments
    avaliacaos.where(status: 'A')
  end

  def pending_assessments
    avaliacaos.where(status: 'AP')
  end

  def active?
    status == 'A'
  end

  private

  def unique_name_validation
    products = Produto.where("status in ('A','P') and lower(nome) = LOWER(replace('#{self.nome}','-',' '))")
    return if products.blank?
    return if products.ids.include?(self.id)
    errors.add(:nome, 'já em uso') if products.ids.count > 0
  end

  def product_image_format
    if product_image_width != product_image_height
      errors.add(:product_image, 'Imagem deve ser quadrada e ter no máximo 500x500px')
    end
  end
end
