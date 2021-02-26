class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name,  null: false
      t.string :adress, null: false
      t.string :station
      t.integer :price, null: false
      t.text :store_time, null: false
      t.string :link
      t.references :owner_user, foreign_key: true
      t.timestamps
    end
  end
end
