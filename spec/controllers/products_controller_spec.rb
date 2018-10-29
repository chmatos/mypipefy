# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  render_views

  describe 'Authenticated User' do
    let(:oauth_account) { FactoryBot.create(:oauth_account) }

    before do
      allow_any_instance_of(SparksMailer).to receive(:novo_usuario).and_return(true)
      session[:uid] = oauth_account.uid
    end

    describe 'GET #new' do
      before do
        get :new
      end

      it do
        expect(response).to render_template(:new)
      end
    end

    describe 'GET "show"' do
      let!(:product) { create(:produto, nome: 'testname') }

      before do
        get :show, params: { url: 'testname' }
      end

      it do
        expect(response.status).to eq(200)
        expect(response).to render_template(:show)
      end
    end

    describe 'POST "create"' do
      let!(:questionario) { create(:questionario, status: 'A') }
      let(:product) { build(:produto) }

      before do
        post :create, params: {
          produto: product.attributes.except(:id).merge(
            product_image: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/logo.png'))
          )
        }
      end

      it do
        expect(response).to redirect_to(thanks_products_path(url: product.nome.parameterize.downcase))
        expect(assigns(:product).status).to eq('P')
      end
    end

    describe 'GET "demo"' do
      let!(:product) { create(:produto, nome: 'testname') }
      let(:double_demo_produto) { instance_double(SparksMailer) }

      before do
        get :demo, params: { id: 'testname' }, xhr: true
      end

      it do
        expect(response.status).to eq(204)
        expect(product.leads.size).to eq(1)

        lead = product.leads.last
        expect(lead.oauth_account).to eq(oauth_account)
      end
    end

    describe 'GET #edit' do
      let!(:product) { create(:produto, nome: 'testname', oauth_account_adm: oauth_account) }

      before do
        get :edit, params: { url: 'testname' }
      end

      it do
        expect(response).to render_template(:edit)
      end
    end

    describe 'PATCH #update' do
      let!(:product) { create(:produto, nome: 'testname', oauth_account_adm: oauth_account) }

      context 'valid case' do
        before do
          patch :update, params: { id: product.id, produto: { nome: 'B2B Stack' } }
        end

        it do
          expect(response).to redirect_to(thanks_products_path(url: 'b2b-stack'))
          expect(assigns(:product).object.status).to eq('A')
        end
      end

      context 'invalid case' do
        before do
          patch :update, params: { id: product.id, produto: { nome: '' } }
        end

        it do
          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe 'Unauthenticated User' do
    describe 'GET #new' do
      before do
        get :new
      end

      it do
        expect(response).to redirect_to(login_to_setup_path)
      end
    end

    describe 'GET #edit' do
      let!(:product) { create(:produto, nome: 'testname') }

      before do
        get :edit, params: { url: 'testname' }
      end

      it do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
