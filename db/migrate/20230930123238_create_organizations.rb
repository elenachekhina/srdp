class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations, id: :uuid do |t|
      t.string :name,               null: false, default: ''
      t.string :email,              null: false, default: ''
      t.string :description
      t.string :password_digest,    null: false, default: ''


      t.timestamps
    end
  end
end
