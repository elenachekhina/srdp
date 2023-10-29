class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services, id: :uuid do |t|
      t.belongs_to :organization, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.text :description
      t.string :duration
      t.decimal :pricing, precision: 10, scale: 2
      t.string :currency, default: 'USD'

      t.timestamps
    end
  end
end
