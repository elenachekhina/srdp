# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts, id: :uuid do |t|
      t.belongs_to :organization, null: false, foreign_key: true, type: :uuid
      t.string :type
      t.string :value

      t.timestamps
    end
  end
end
