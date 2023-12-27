class ModifyAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :house_number, :string
    add_column :addresses, :district, :string

    add_column :addresses, :latitude_ovr, :float
    add_column :addresses, :longitude_ovr, :float
  end
end
