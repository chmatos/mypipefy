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
    if ENV['LOG_API'] == 'true'
      puts "api response: [#{args[0][:status]}]"
      puts JSON.pretty_generate(args[0][:json])
    end

    render *args, &blk
  end
end
