class CreateRates < ActiveRecord::Migration[7.1]
  def change
    create_table :rates, id: :uuid do |t|
      t.references :rateable, polymorphic: true, null: false, type: :uuid
      t.references :rater, polymorphic: true, null: false, type: :uuid
      t.string :comment
      t.integer :value, null: false, default: 0

      t.timestamps
    end
  end
end
