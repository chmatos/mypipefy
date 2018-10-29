# frozen_string_literal: true

module ProductHelper
  def demo_button_helper(product)
    attrs = { class: 'button primary icon-download' }
    if current_user
      attrs[:onclick] = '$("#modal-demo").fadeIn();'
      attrs[:remote] = true
      url = demo_product_path(product.custom_name)
    else
      attrs[:onclick] = '$("#modal-login").fadeIn();'
      url ='#'
    end

    link_to 'Solicitar demo', url, attrs
  end

  def product_manager_helper?(product:, user:)
    return false if product.nil? || user.nil?
    user && product.oauth_account_adm == user
  end

  def assessment_button_helper(product)
    attrs = { class: 'button secondary icon-star-alt' }

    if current_user && [product.approved_assessments.to_a + product.pending_assessments.to_a].flatten.map(&:oauth_accounts_id).include?(current_user.id)
      link_to 'Avalie a Solução', '#', attrs.merge(onclick: "$('#modal-assessment').fadeIn()")
    else
      link_to 'Avalie a Solução', new_avalicacao_path(@product.custom_name), attrs
    end
  end
end
