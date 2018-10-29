# frozen_string_literal: true

class AssessmentsController < ApplicationController
  before_action :authenticated_user?, only: [:new, :create]
  before_action :load_categories, :load_product, :load_questionario_produto, :load_assessment, :validate_active_assessments, except: [:thanks]
  before_action :validate_pending_assessments, only: [:new]

  include ProductQueries

  def new
    @assessment.status = 'P'
    @assessment.save
    build_questionario_respostas
  end

  def create
    @assessment.update_attributes(avaliacao_params)
    @assessment.status = 'AP'

    if @assessment.save
      SparksMailer.nova_avaliacao(@assessment).deliver_later!
      success_redirect_to
    else
      render :new
    end
  end

  def thanks
    build_featured_products
    build_top_rated_products
  end

  private

  def avaliacao_params
    params.require(:avaliacao).permit(questionario_respostas_attributes: [:questionario_pergunta_id, :resposta, :id])
  end

  def load_assessment
    @assessment ||= Avaliacao.find_or_initialize_by(questionario_id: @questionario_produto.questionario_id, produto_id: @product.id, oauth_accounts_id: current_user.id)
  end

  def load_categories
    main_categories = Categoria.includes(:categorias).active.segment.order("nome")

    @main_categories = main_categories.map do |category|
      next if category.categorias.blank?
      [ "#{category.nome}", category.categorias.to_a.map(&:nome) ]
    end.uniq.compact!
  end

  def load_product
    @product ||= ProductDecorator.new(Produto.active.find_by_name(params[:url]))
  end

  def load_questionario_produto
    @questionario_produto ||= @product.questionario_produtos.active.first
  end

  def validate_active_assessments
    redirect_to root_path, notice: 'Você já avaliou este produto, Agradecemos sua participação.' and return if @product.avaliacaos.active.where(oauth_accounts_id: current_user.id).count > 0
  end

  def validate_pending_assessments
    redirect_to root_path, notice: 'Você já avaliou este produto, Agradecemos sua participação.' and return if @product.avaliacaos.pending.where(oauth_accounts_id: current_user.id).count > 0
  end

  def build_questionario_respostas
    return if @assessment.questionario_respostas.count > 0
    @questionario_produto.questionario.questionario_perguntas.each do |pergunta|
      @assessment.questionario_respostas.build(questionario_pergunta: pergunta)
    end
  end

  def success_redirect_to
    if params[:landing] == 'true'
      redirect_to landing_nova_avaliacao_obrigado_path and return
    else
      redirect_to thanks_assessments_path and return
    end
  end
end
