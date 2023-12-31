# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses, id: :uuid do |t|
      t.belongs_to :organization, null: false, foreign_key: true, type: :uuid
      t.string :street
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.float  :latitude
      t.float  :longitude

      t.timestamps
    end
  end
end
