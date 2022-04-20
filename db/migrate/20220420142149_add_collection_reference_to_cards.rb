class AddCollectionReferenceToCards < ActiveRecord::Migration[7.0]
  def change
    add_reference :cards, :collection, foreign_key: true
  end
end
