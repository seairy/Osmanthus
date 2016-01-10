class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :uuid, limit: 36, null: false
      t.string :open_id, limit: 28
      t.string :phone, limit: 11
      t.string :nickname, limit: 50
      t.string :portrait, limit: 50
      t.string :gender_cd, limit: 8
      t.string :state, limit: 20, null: false
      t.timestamps null: false
    end
  end
end