# frozen_string_literal: true
ActionMailer::DeliveryJob.rescue_from(SparkPostRails::DeliveryException) do |exception|
  logger.error "EMAIL JOB - Fala no Envio de Email"
  logger.error exception
end