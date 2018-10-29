# frozen_string_literal: true

class Lead < ApplicationRecord
  belongs_to :oauth_account
  belongs_to :produto

  validates :produto, :oauth_account, presence: true
end
