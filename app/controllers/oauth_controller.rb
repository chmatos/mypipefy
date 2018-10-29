# frozen_string_literal: true

class OauthController < ApplicationController
  skip_before_action :check_request_url, :check_login_expires

  def callback
    oauth_service = OauthService.new(request.env['omniauth.auth'])
    omniauth_params = request.env['omniauth.params']
    return_url = session[:request_url]
    return_url ||= session[:previous_request_url]
    current_user = oauth_service.find_or_create
    if current_user
      oauth_service.update_picture
      session[:uid] = current_user.uid
      session[:expires_at] = Time.zone.now + 24.hours
      flash.clear
      flash[:success] = "Bem vindo, #{current_user.name}!"
      redirect_to(return_url || root_url)
    end
  rescue StandardError => e
    redirect_to oauth_failure_url
  end

  def login
    return_url = session[:return_url] || root_path
  end

  def failure
    flash.clear
    flash[:danger] = 'Falha na autenticação com o LinkedIn, tente novamente!'
    render(layout: 'layouts/application')
  end

  def destroy
    redirect_to root_path unless current_user
    session.destroy
    url = request.referer unless request.referer.include?('novo_produto') || request.referer.include?('entrar_para_avaliar') || request.referer.include?('avaliacao/')
    redirect_to(url || root_path) && return
  end
end
