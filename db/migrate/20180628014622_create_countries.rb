# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    unless table_exists?(:countries)
      create_table :countries, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=latin1' do |t|
        t.string :name, limit: 1000

        t.timestamps null: false
      end
    end
  end
end
