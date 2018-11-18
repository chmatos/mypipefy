# frozen_string_literal: true

# inicializes
# rs = RankingService.new(product_id: product_id)
# rs = RankingService.new(category_id: category_id)

# functions
# rs.product(product_id: nil)
# rs.category(category_id: nil)

class RankingService
  def initialize(product_id: nil, category_id: nil)
    @product_id = product_id
    @category_id = category_id
  end

  def category(category_id: nil)
    category_id ||= @category_id
    category = Categoria.find_by(id: category_id)
    return [] if category.blank?

    products = ProductDecorator.decorate_collection(category.produtos.active)
    products.map { |product| product_json(product) }
  end

  def product(product_id: nil)
    product_id ||= @product_id
    product = Produto.find_by(id: product_id)
    return {} if product.blank?

    product = ProductDecorator.decorate(product)
    product_json(product)
  end

  def product_json(product)
    {
      product_id: product.id,
      nome: product.nome,
      coordenadaX: product.average_all_notes,
      coordenadaY: product.count_reviews,
      imagePath: product.small_product_image
    }
  end
end
