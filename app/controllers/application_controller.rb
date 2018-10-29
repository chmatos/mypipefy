# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protect_from_forgery with: :exception

  before_action :check_request_url, :check_login_expires

  def set_cache_buster
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end

  def logged?
    !current_user.nil?
  end

  def current_user
    @current_user ||= OauthAccount.find_by(uid: session[:uid])
  end

  def current_url
    request.path
  end

  def authenticated_user?
    redirect_to(login_to_setup_path) && return if !logged? && request.url.include?('produto/novo_produto')
    redirect_to(session[:previous_request_url] || root_path, notice: 'Para acessar essa página é preciso estar logado') && return unless logged?
  end

  def to_slug
    ret = strip
    ret.tr(' ', '-')
  end

  def main_categories_list
    categories = Categoria
                 .active
                 .includes(:produtos)
                 .main
                 .order(:nome)
                 .to_a
                 .reject { |c| c.produtos.blank? }

    @main_categories_list ||= CategoryDecorator.decorate_collection(categories)
  end

  def default_assessment
    @default_assessment ||= Questionario.find_by(status: 'A')
  end

  def check_request_url
    flash
    unless params[:controller] == 'oauth'
      session[:previous_request_url] = session[:current_request_url]
      session[:current_request_url] = request.url
    end
  end

  helper_method :current_user, :current_url, :to_slug, :main_categories_list

  def load_product_by_url
    @product = ProductDecorator.new(Produto.find_by_name(params[:url]))
    return if current_user && @product.oauth_account_adm == current_user
  end

  protected

  def not_found
    redirect_to not_found_error_path
  end

  def check_login_expires
    return true if params[:controller] == 'oauth'
    if current_user && session[:expires_at]
      return true if session[:expires_at] > Time.zone.now
      session.destroy
    end
    true
  end
end
