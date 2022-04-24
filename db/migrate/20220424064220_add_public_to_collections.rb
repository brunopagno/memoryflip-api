class AddPublicToCollections < ActiveRecord::Migration[7.0]
  def change
    add_column :collections, :public, :boolean, default: false
  end
end
