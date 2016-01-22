class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :uuid, limit: 36, null: false
      t.references :travel, null: false
      t.references :user, null: false
      t.string :content, limit: 5000, null: false
      t.integer :quantity, limit: 1, null: false
      t.references :acceptable_price
      t.references :actual_price
      t.string :state, limit: 20, null: false
      t.timestamps null: false
    end
  end
end