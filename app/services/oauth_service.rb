# frozen_string_literal: true

class OauthService
  attr_reader :auth_hash

  def initialize(omniauth_params)
    @omniauth_params = omniauth_params
  end

  def find_or_create
    return account if account
    OauthAccount.create!(parsed_params)
  end

  def update_picture
    account.update(image_url: parsed_params[:profile_url])
  end

  private

  def account
    @account ||= OauthAccount.find_by(uid: @omniauth_params[:uid])
  end

  def parsed_params
    {
      uid: @omniauth_params[:uid],
      provider: @omniauth_params[:provider],
      image_url: @omniauth_params[:info][:image],
      email: @omniauth_params[:extra][:raw_info][:emailAddress],
      headline: @omniauth_params[:extra][:raw_info][:headline],
      name: @omniauth_params[:extra][:raw_info][:firstName] + ' ' + @omniauth_params[:extra][:raw_info][:lastName],
      industry: @omniauth_params[:extra][:raw_info][:industry],
      profile_url: @omniauth_params[:info][:image],
      raw_data: @omniauth_params[:extra][:raw_info].to_json
    }
  end
end
