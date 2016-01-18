class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :currency, null: false
      t.decimal :rate_of_exchange, precision: 7, scale: 2, null: false
      t.decimal :in_foreign, precision: 7, scale: 2, null: false
      t.decimal :in_local, precision: 7, scale: 2, null: false
      t.timestamps null: false
    end
  end
end