class AddExpiresAtToSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :sessions, :expires_at, :datetime
  end
end
