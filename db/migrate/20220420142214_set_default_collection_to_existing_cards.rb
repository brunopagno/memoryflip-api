class SetDefaultCollectionToExistingCards < ActiveRecord::Migration[7.0]
  def change
    User.all.each do |user|
      user.collections.create!(name: 'Default collection')
      Card.where(user_id: user.id).update_all(collection_id: user.collections.first.id)
    end
  end
end
