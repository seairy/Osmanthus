class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.references :travel, null: false
      t.references :country, null: false
      t.timestamps null: false
    end
  end
end