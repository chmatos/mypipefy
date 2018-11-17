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
    return [] unless category.present?

    products_array = []
    products = ProductDecorator.decorate_collection(category.produtos.active)
    products.each do |product|
      products_array << product_json(product)
    end
    products_array
  end

  def product(product_id: nil)
    product_id ||= @product_id
    product = Produto.find_by(id: product_id)
    return {} unless product.present?

    product = ProductDecorator.decorate(product)
    product_json(product)
  end

  def product_json(product)
    coordenada_y = ((product.questionario_respostas.approved.rated_questions.recommendation_question.count +
                     product.questionario_respostas.approved.rated_questions.ease_use_question.count +
                     product.questionario_respostas.approved.rated_questions.client_support_question.count +
                     product.questionario_respostas.approved.rated_questions.cost_benefit_question.count +
                     product.questionario_respostas.approved.rated_questions.functionality_question.count) / 5).round(2) || 0.00

    coordenada_x = if coordenada_y.zero?
                     0.00
                   else
                     ((product.average_note_recommendation +
                       product.average_note_ease_use +
                       product.average_note_client_support +
                       product.average_note_cost_benefit +
                       product.average_note_functionality) / 5).round(2) || 0.00
                   end
    {
      product_id: product.id,
      nome: product.nome,
      coordenadaX: coordenada_x,
      coordenadaY: coordenada_y,
      imagePath: product.small_product_image
    }
  end
end
