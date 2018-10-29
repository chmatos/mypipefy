# frozen_string_literal: true

class Categoria < ApplicationRecord
  has_and_belongs_to_many :produtos
  has_many :categoria_produtos
  belongs_to :parent, class_name: 'Categoria', optional: true
  has_many :categorias, foreign_key: :parent_id

  scope :active,   -> { where(status: 'A') }
  scope :featured, -> { where(featured: true).order(:featured_position) }
  scope :main,     -> { where(parent_id: 0, tipo: 'categ') }
  scope :segment,  -> { where(tipo: 'segment') }

  def self.find_by_name(name)
    category = find_by("LOWER(nome) = LOWER(replace('#{name}','-',' '))")
    category ||= (find_by("LOWER(replace(nome,' ','')) = LOWER(replace('#{name}','-',''))") ||
      find_by("LOWER(nome) = LOWER(replace('#{name}','-','.'))") ||
      find_by("LOWER(nome) = LOWER('#{name}')")
    )

    raise ActiveRecord::RecordNotFound if category.blank?
    category
  end

  def featured_products(count = 3)
    produtos.active.order('avaliacaos_count DESC').take(count)
  end

  def child_categories
    categorias.where(tipo: 'categ')
  end
end
