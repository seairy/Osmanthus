class CreateTravels < ActiveRecord::Migration
  def change
    create_table :travels do |t|
      t.string :uuid, limit: 36, null: false
      t.references :user, null: false
      t.date :departure_at, null: false
      t.date :return_at, null: false
      t.text :description
      t.string :state, limit: 20, null: false
      t.timestamps null: false
    end
  end
end