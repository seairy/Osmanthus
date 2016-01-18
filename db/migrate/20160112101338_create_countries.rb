class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :uuid, limit: 36, null: false
      t.string :zh_name, limit: 50, null: false
      t.string :en_name, limit: 50, null: false
      t.string :flag, limit: 50
      t.boolean :featured, null: false
      t.timestamps null: false
    end
  end
end