class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.belongs_to :organization
      t.string :website_url
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
