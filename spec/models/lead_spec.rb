# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lead, type: :model do
  describe 'Relationships' do
    it { should belong_to(:oauth_account) }
    it { should belong_to(:produto) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:oauth_account) }
    it { should validate_presence_of(:produto) }
  end
end
