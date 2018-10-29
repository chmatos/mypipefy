# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: %("Eduardo Müller" <eduardo@b2bstack.net>), layout: :mailer
end
