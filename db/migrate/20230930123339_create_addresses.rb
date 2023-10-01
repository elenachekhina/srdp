class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.belongs_to :organization
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
