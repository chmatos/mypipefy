# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductHelper, type: :helper do
  let(:product) { create(:produto) }

  describe '#product_manager_helper?' do
    context 'no current user' do
      it do
        expect(helper.product_manager_helper?(product: product, user: nil)).to be false
      end
    end

    context 'no product' do
      it do
        user = create(:oauth_account)
        expect(helper.product_manager_helper?(product: nil, user: user)).to be false
      end
    end

    context 'not admin user' do
      it do
        user = create(:oauth_account)
        expect(helper.product_manager_helper?(product: product, user: user)).to be false
      end
    end

    context 'valid admin user' do
      let(:user) { create(:oauth_account) }

      before do
        product.update(oauth_account_adm: user)
      end

      it do
        expect(helper.product_manager_helper?(product: product, user: user)).to be true
      end
    end
  end
end
