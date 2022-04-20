class RemoveUsersReferenceFromCards < ActiveRecord::Migration[7.0]
  def change
    remove_reference :cards, :user
  end
end
