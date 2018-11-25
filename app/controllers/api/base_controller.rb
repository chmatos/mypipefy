# frozen_string_literal: true

class Api::BaseController < ActionController::Base
  private

  def authenticate_application(_app_nome = 'cliente')
    authenticate_or_request_with_http_token do |token, _options|
      return true if token == ENV['TOKEN_API']

      render status: :unauthorized, json: { erro: 'APP Invalido' }
      return false
    end
  end

  def api_render(*args, &blk)
    render *args, &blk
  end
end
