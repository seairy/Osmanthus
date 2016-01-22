class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :currency
      t.decimal :rate_of_exchange, precision: 8, scale: 4
      t.decimal :in_foreign, precision: 10, scale: 2
      t.decimal :in_local, precision: 10, scale: 2, null: false
      t.timestamps null: false
    end
  end
end