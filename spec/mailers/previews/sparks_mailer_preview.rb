# frozen_string_literal: true

class SparksMailerPreview < ActionMailer::Preview
  def demo_produto
    SparksMailer.demo_produto(Produto.first, OauthAccount.first)
  end

  def user_demo_product
    SparksMailer.user_demo_product(Produto.first, OauthAccount.first)
  end
end
