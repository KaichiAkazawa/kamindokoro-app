class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.references :customer_user, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
