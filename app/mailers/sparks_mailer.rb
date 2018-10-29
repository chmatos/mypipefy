# frozen_string_literal: true

class SparksMailer < ActionMailer::Base
  default from: %("Eduardo Müller" <eduardo@b2bstack.net>), layout: :mailer

  def nova_avaliacao(avaliacao)
    @avaliacao = avaliacao
    @avaliador = OauthAccount.find_by(id: @avaliacao.oauth_accounts_id)
    @produto   = Produto.where(id: @avaliacao.produto_id).select(:nome).first
    @aval_rev_url = categorias_url
    nome          = @avaliador.name
    @firstName    = nome.split[0]
    email_to      = %("#{nome}" <#{@avaliador.email}>)

    mail(to: email_to, subject: "Você deixou uma avaliação no B2B Stack")
  end

  def novo_usuario(usuario)
    @usuario      = usuario
    @aval_rev_url = categorias_url
    nome          = usuario.name
    @firstName    = nome.split[0]
    email_to      = %("#{nome}" <#{@usuario.email}>)

    mail(to: email_to, subject: "Bem vindo ao B2B Stack")
  end

  def novo_produto(produto)
    @produto = produto

    if @produto.oauth_accounts_id
      @avaliado = OauthAccount.find(@produto.oauth_accounts_id)
      if @avaliado
        nome       = @avaliado.name
        @firstName = nome.split[0]
        email_to   = %("#{nome}" <#{@avaliado.email}>)

        mail(to: email_to, subject: "Cadastro de Novo Produto no B2B Stack")
      end
    end
  end

  def demo_produto(produto, user)
    @produto = produto
    @user    = user

    mail(to: 'leads@b2bstack.net', subject: "Novo Lead para #{@produto.nome}", cco: 'notify@b2bstack.net')
  end

  def user_demo_product(product, user)
    @product = product
    @user    = user

    mail(to: user.email, subject: "Solicitação de Demo para #{@product.nome}", cco: 'notify@b2bstack.net')
  end
end
