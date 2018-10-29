# frozen_string_literal: true

class AssessmentDecorator < ApplicationDecorator
  delegate_all

  def oauth_account_name
    public_profile? ? object.oauth_account.name : 'Usuário B2B Stack'
  end

  def oauth_account_headline
    public_profile? ? object.oauth_account.headline : ''
  end

  def oauth_account_image_url
    url = oauth_account.image_url.blank? ? 'no-profile-image.png' : oauth_account.image_url
    public_profile? ? url : 'no-profile-image.png'
  end

  def public_profile?
    answer = object.questionario_respostas.find_by(questionario_pergunta: 14)
    return true if answer.blank?
    answer.resposta.to_i == 1
  end
end
