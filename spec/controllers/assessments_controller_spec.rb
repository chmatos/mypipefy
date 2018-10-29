# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssessmentsController, type: :controller do
  render_views

  let(:questionario) { create(:questionario, status: 'A') }
  let!(:product)     { create(:produto, nome: 'test name') }

  context 'Authenticated User' do
    let(:oauth_account) { FactoryBot.create(:oauth_account) }

    before do
      product.questionario_produtos.create(questionario: questionario)
      allow_any_instance_of(SparksMailer).to receive(:novo_usuario).and_return(true)
      session[:uid] = oauth_account.uid
    end

    describe 'GET #new' do
      before do
        get :new, params: { url: 'test-name' }
      end

      it {
        expect(response.status).to eq(200)
        expect(response).to render_template(:new)
      }
    end

    describe 'POST #create' do
      let(:assessment)   { create(:avaliacao, oauth_accounts_id: oauth_account.id, produto_id: product.id) }
      let(:questionario) { assessment.questionario }

      before do
        questionario.questionario_perguntas << build(:questionario_pergunta)
        questionario.save
        post :create, params: { url: 'test-name', avaliacao: { questionario_respostas_attributes: { '0' => { questionario_pergunta_id: questionario.questionario_perguntas.last.id, resposta: 'test' } } } }
      end

      it {
        expect(response).to redirect_to(thanks_assessments_path)
      }
    end

    describe 'GET "thanks"' do
      let(:product01) { create(:produto) }
      let(:product02) { create(:produto) }
      let(:product03) { create(:produto) }

      before do
        create_list(:avaliacao, 3, produto_id: product01.id)
        create_list(:avaliacao, 4, produto_id: product02.id)
        create_list(:avaliacao, 2, produto_id: product03.id)
        get :thanks
      end

      it {
        expect(response).to render_template(:thanks)
        expect(assigns(:featured_products)).to eq(ProductDecorator.decorate_collection([product02, product01, product03, product]))
      }
    end
  end

  context 'unauthenticated user' do
    before do
      get :new, params: { url: 'test-name' }
    end

    it do
      expect(response).to redirect_to(root_path)
    end
  end
end
