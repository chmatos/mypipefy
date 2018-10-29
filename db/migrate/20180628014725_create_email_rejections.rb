# frozen_string_literal: true

class CreateEmailRejections < ActiveRecord::Migration[5.1]
  def change
    unless table_exists?(:email_rejections)
      create_table :email_rejections, id: :bigint, default: nil, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=latin1' do |t|
        t.string :email, limit: 500
        t.datetime :data, default: -> { 'CURRENT_TIMESTAMP' }
      end
    end
  end
end
