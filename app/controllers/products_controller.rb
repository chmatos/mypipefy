# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :load_product_by_url, only: [:show, :edit]
  before_action :load_product_by_id,  only: [:update]
  before_action :authenticated_user?, only: [:new, :create, :edit, :update]
  before_action :load_countries, :load_price_kinds, only: [:new, :edit]

  def new
    @product = Produto.new
  end

  def create
    @product = Produto.new(product_attributes)
    associate_admin_product

    @product.oauth_accounts_id = current_user.id
    @product.nome = @product.nome.gsub('-',' ')
    @product.status = 'P'
    @product.questionario_produtos.build(status: 'A', questionario: default_assessment)

    if @product.save
      SparksMailer.novo_produto(@product).deliver_later!
      redirect_to thanks_products_path(url: @product.nome.parameterize.downcase), notice: 'Produto cadastrado com sucesso!'
    else
      load_countries
      load_price_kinds
      render :new, notice: 'Preencha os campos pendentes'
    end
  end

  def show
    @main_category = @product.main_category
    @main_category_featured_products = ProductDecorator.decorate_collection(@main_category.featured_products) if @main_category
    @assessments = AssessmentDecorator.decorate_collection(@product.approved_assessments.with_oauth_account.with_answers.newer)
  end

  def edit
    raise ActiveRecord::RecordNotFound unless current_user && @product.oauth_account_adm == current_user
  end

  def update
    product = @product.object

    product.nome = @product.nome.gsub('-',' ')

    if product.update_attributes(product_attributes)
      redirect_to thanks_products_path(url: product.nome.parameterize.downcase), notice: 'Produto atualizado com sucesso!'
    else
      load_countries
      load_price_kinds
      render :edit
    end
  end

  def demo
    @product = ProductDecorator.new(Produto.active.find_by_name(params[:id]))

    @product.leads.create(oauth_account: current_user)

    SparksMailer.demo_produto(@product, current_user).deliver_later!
    SparksMailer.user_demo_product(@product, current_user).deliver_later!
  end

  def thanks; end

  def checkprod
    existe = true
    keyword = ''
    keyword_slug = params[:q]
    if keyword_slug
      keyword = keyword_slug.gsub('-',' ')
    end
    if keyword
      #minimo de 3 caracteres
      if keyword.length >= 3
        keyword = keyword.downcase
        existe = Produto.where("status in ('A','P') and lower(nome) = LOWER(replace(?,'-',' '))", keyword).count > 0
      end
    end
    render json: { existe: existe }
  end

  def login_to_setup
    redirect_to novo_produto_path and return if current_user
  end

  private

  def load_product_by_id
    @product = ProductDecorator.new(Produto.find_by(id: params[:id], oauth_accounts_id_adms: current_user.id))
  end

  def load_countries
    @countries = Country.select(:id, :name).map{|c| [c.name, c.id] }
  end

  def load_price_kinds
    @price_kinds = [['Mensal', :monthly], ['Anual', :annual]]
  end

  def associate_admin_product
    if params[:adm] == 'on'
      @product.oauth_accounts_id_adms = current_user.id
    end
  end

  def product_attributes
    params.require(:produto).permit(:nome, :descricao, :ideal_profile,
      :initial_price, :price_kind, :trial_other_text, :access_web_navigation,
      :access_mobile_ios, :access_mobile_android, :access_desktop_pc,
      :access_desktop_apple, :access_desktop_linux, :support_email,
      :support_chat, :support_phone, :training_video, :training_text,
      :training_presential, :training_ebook, :country_id, :start_year,
      :url, :tipo, :fab_nome, :fab_url, :terms_and_conditions, :trial_kind,
      :support_hour_kind, :product_image
    )
  end
end
