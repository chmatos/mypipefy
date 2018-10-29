# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SparksMailer, type: :mailer do
  let(:product) { create(:produto) }
  let!(:user) { create(:oauth_account, email: 'hey@mail.com') }

  describe '#user_demo_product' do
    let(:mail) { described_class.user_demo_product(product, user) }

    it 'renders the subject' do
      expect(mail.subject).to eq("Solicitação de Demo para #{product.nome}")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq(['hey@mail.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['eduardo@b2bstack.net'])
    end

    it 'renders first name' do
      expect(mail.body.encoded).to match(user.first_name)
    end
  end
end
