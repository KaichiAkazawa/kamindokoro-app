class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :text
      t.integer :score
      t.references :customer_user, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
