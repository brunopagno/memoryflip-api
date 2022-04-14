class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.string :token, null: false, blank: false
      t.references :user, null: false, foreign_key: true

      t.timestamps

      t.index :token, unique: true
    end
  end
end
