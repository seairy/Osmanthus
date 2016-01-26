class CreateDealPhotographs < ActiveRecord::Migration
  def change
    create_table :deal_photographs do |t|
      t.references :deal, null: false
      t.string :type_cd, limit: 20, null: false
      t.string :file, limit: 50, null: false
      t.timestamps null: false
    end
  end
end
