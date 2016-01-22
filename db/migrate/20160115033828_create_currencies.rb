class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :uuid, limit: 36, null: false
      t.string :name, limit: 20, null: false
      t.string :iso_code, limit: 3, null: false
      t.decimal :rate_of_exchange, precision: 8, scale: 4, null: false
      t.timestamps null: false
    end
  end
end