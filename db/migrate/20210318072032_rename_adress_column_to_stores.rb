class RenameAdressColumnToStores < ActiveRecord::Migration[6.0]
  def change
    rename_column :stores, :adress, :address
  end
end
