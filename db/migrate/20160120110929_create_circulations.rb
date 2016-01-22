class CreateCirculations < ActiveRecord::Migration
  def change
    create_table :circulations do |t|
      t.references :country, null: false
      t.references :currency, null: false
      t.timestamps null: false
    end
  end
end